//
//  PUBGControllerManager.m
//  pubc
//
//  Created by Kevin Bradley on 6/15/19.
//  Copyright © 2019 nito. All rights reserved.
//

#import "PUBGControllerManager.h"
#import <GameController/GameController.h>
#import "UIView-KIFAdditions.h"
#include <sys/sysctl.h>
#import "UITouch-KIFAdditions.h"
#import "CGGeometry-KIFAdditions.h"
#import "PUBGDefines.h"
#import "PUBPrefTableViewController.h"
#import "NSObject+AssociatedObjects.h"
#import "UIWindow+Additions.h"

//screen size
#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height

//convenience
#define PAT(x) [self pointForActionType:x]

//logging

#define DLog(format, ...) CFShow((__bridge CFStringRef)[NSString stringWithFormat:format, ## __VA_ARGS__]);
#define LOG_SELF        NSLog(@"%@ %@", self, NSStringFromSelector(_cmd))
#define DLOG_SELF DLog(@"%@ %@", self, NSStringFromSelector(_cmd))

// added so older SDK's can build this without complaining
@interface GCExtendedGamepad (pubc)

@property (nonatomic,readonly) GCControllerButtonInput * leftThumbstickButton;
@property (nonatomic,readonly) GCControllerButtonInput * rightThumbstickButton;

@end

@interface IOSAppDelegate : UIResponder <UIApplicationDelegate, UITextFieldDelegate>

//the root view of pubg application, this is the view touch events need to be relayed through.

@property(retain) UIView *IOSView; // @synthesize IOSView;

@end

@interface PUBGControllerManager ()

@property (readwrite, assign) CGPoint previousPoint; //track the previous point when dragging / moving touches
@property (nonatomic, strong) NSMutableArray *touches; //all of our touches, kept track of when moving so we can change the phase to touch up as needed

@property (readwrite, assign) CGPoint previousRightPoint; //track the previous point when dragging / moving touches
@property (nonatomic, strong) NSMutableArray *rightTouches; //all of our touches, kept track of when moving so we can change the phase to touch up as needed

@property (readwrite, assign) BOOL menuVisible;

@end

@implementation PUBGControllerManager{
    
    UITapGestureRecognizer *touchSurfaceDoubleTapRecognizer;
    BOOL _tapSetup;
}

@synthesize previousPoint, previousRightPoint;

+ (id)sharedManager
{
    static dispatch_once_t onceToken;
    
    static PUBGControllerManager *shared = nil;
    if(shared == nil)
    {
        dispatch_once(&onceToken, ^{
            shared = [[PUBGControllerManager alloc] init];
            shared.touches = [NSMutableArray new];
            shared.rightTouches = [NSMutableArray new];
        });
    }
    return shared;
}

- (UIViewController *)topViewController
{
    return [[[UIApplication sharedApplication] keyWindow] visibleViewController];
}

- (BOOL)menuVisible {
    
    UIViewController *tvc = [self topViewController];
    NSLog(@"tvc: %@", tvc);
    NSString *topViewClass = NSStringFromClass(tvc.class);
    if ([topViewClass containsString:@"PUB"]){
        return TRUE;
    }
    return FALSE;
}

/**
 
 returns the machine type of the device ie: iPad6,3
 
 */

- (NSString *)machine {
    
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    return [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    
}

/**
 
 All input points (for most devices) need to be converted to their appropriate screen size
 All of the on screen button values are mapped to the X,Y coordinates as displayed in the
 default layout on the 6S, we convert the points to the native screen size to make sure the
 offsets are translated properly.
 
 
 */

- (CGPoint)convertPointForScreen:(CGPoint)inputPoint {
    
    if (SCREEN_HEIGHT == 667) {
        return inputPoint;
    }
    //x = (OG_VALUE * TARGET_WIDTH) / OG_WIDTH;
    //y = (OG_VALUE * TARGET_HEIGHT / OG_HEIGHT;
    CGFloat x = (inputPoint.x * SCREEN_WIDTH) / 667;
    CGFloat y = (inputPoint.y * SCREEN_HEIGHT) / 375;
    
    return CGPointMake(x, y);
}

/*
 
 <key>ButtonA</key>
 <string>PGBActionTypeJump</string>
 <key>ButtonB</key>
 <string>PGBActionTypeConceal</string>
 <key>ButtonX</key>
 <string>PGBActionTypeRun</string>
 <key>ButtonY</key>
 <string>PGBActionTypeCrouch</string>
 <key>LeftShoulder</key>
 <string>PGBActionTypeTrainingButton</string>
 <key>RightShoulder</key>
 <string>PGBActionTypeStartButton</string>
 <key>LeftTrigger</key>
 <string>PGBActionTypePeakLeft</string>
 <key>RightTrigger</key>
 <string>PGBActionTypeRight</string>
 <key>RightThumbstickButton</key>
 <string>PGBActionHandAction</string>
 <key>LeftThumbstickButton</key>
 <string>PGBActionFirstItemSelect</string>
 <key>Dpad.up</key>
 <string>PGBActionTypeAim</string>
 <key>Dpad.down</key>
 <string>PGBActionMapAction</string>
 <key>Dpad.left</key>
 <string>PGBActionTypeFirstWeapon</string>
 <key>Dpad.right</key>
 <string>PGBActionTypeSecondWeapon</string>
 <key>Menu</key>
 <string>PGBActionTypeSmallWeapon</string>
 
 
 */

/**
 
 The controller preferences are stored here, keys are mapped like the following
 
 ButtonA: PGBActionTypeJump
 
 all these are defined in PUBGDefines.h
 
 It should be pretty self explanatory from here
 
 */

-(void)handleTouchSurfaceDoubleTap:(UITapGestureRecognizer *)sender {
    if (sender.state == UIGestureRecognizerStateEnded) {
        ///[self toggleMode];
        if (!self.menuVisible){
            [self showControlEditingView];
            //self.menuVisible = true;
        }
    }
}

- (void)showControlEditingView {
    
    NSLog(@"showControlEditingView");
    PUBPrefTableViewController *prefs = [PUBPrefTableViewController new];
    UIViewController *rvc = [[[UIApplication sharedApplication] keyWindow] rootViewController];
    dispatch_async(dispatch_get_main_queue(), ^{
   
        UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:prefs];
        [rvc presentViewController:nc animated: true completion: nil];
        
    });
}

- (BOOL)experimentalMode {
    
    return [self.controllerPreferences[ExperimentalControl] boolValue];
}

- (NSDictionary *)controllerPreferences {
    
    /* TODO: this will require the game is reloaded for any changes made to the controller layout,
     should get this working through defaults somehow - but at that point it should have a preference loader bundle
     */
    if (self.gamePlayDictionary == nil){
        NSString *preferenceFile = @"/var/mobile/Library/Preferences/com.nito.pubc.plist";
        NSString *localFile = [[self documentsFolder] stringByAppendingPathComponent:@"com.nito.pubc.plist"];
        NSFileManager *man = [NSFileManager defaultManager];
        if (![man fileExistsAtPath:localFile]){
            [man copyItemAtPath:preferenceFile toPath:localFile error:nil];
        }
        NSLog(@"PUBC: localFile: %@", localFile);
        self.gamePlayDictionary = [NSDictionary dictionaryWithContentsOfFile:localFile];
        if (![[self.gamePlayDictionary allKeys] containsObject:ExperimentalControl]){
            NSMutableDictionary *fixed = [self.gamePlayDictionary mutableCopy];
            [fixed setValue:[NSNumber numberWithBool:TRUE] forKey:ExperimentalControl];
            [fixed writeToFile:localFile atomically:TRUE];
            self.gamePlayDictionary = fixed;
        }
        //NSLog(@"gameplay dict: %@", self.gamePlayDictionary);
    }
    return self.gamePlayDictionary;
}

- (void)updateGamplayValue:(id)value forKey:(NSString *)theKey {

    if (theKey != nil && value != nil){
        NSMutableDictionary *dictionary = [self.controllerPreferences mutableCopy];
        NSString *preferenceFile = [[self documentsFolder] stringByAppendingPathComponent:@"com.nito.pubc.plist"];
        [dictionary setValue:value forKey:theKey];
        NSLog(@"updatedDictionary: %@", dictionary);
        self.gamePlayDictionary = dictionary;
        [dictionary writeToFile:preferenceFile atomically:true];
    }

}

/**
 
 IOSView (of class type FIOSView) is the main root view being displayed at all times in pubg
 that is where we need to route all touch events, there is a reference to it in
 IOSAppDelegate (the main app delegate class for pubg).
 
 */

- (UIView *)IOSView {
    
    return [(IOSAppDelegate*)[[UIApplication sharedApplication] delegate] valueForKey:@"IOSView"];
    
}

- (void)controllerDisconnected:(NSNotification *)n {
    
    if (n.object == self.gameController){
        NSLog(@"game controller gone: %@", self.gameController);
        self.gameController = nil;
    }
    
}

- (void)listenForControllers {
    
    _tapSetup = false;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controllerConnected:) name:GCControllerDidConnectNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controllerDisconnected:) name:GCControllerDidDisconnectNotification object:nil];
    
   
    
}



/**
 
 Take the MFI controller that was detected and add valueChangedHandlers. These allow me to listen for button
 presses and simulate touch events to to correspond to how a user would press a button on the screen.
 
 */

- (NSInteger)selectOrStartMode {
    
    NSInteger selectValue = 1;
    NSInteger startValue = 2;
    NSInteger ourValue = 0;
    GCExtendedGamepadSnapshot *snapshot = self.gameController.extendedGamepad.saveSnapshot;
    BOOL lrs = (snapshot.leftShoulder.isPressed && snapshot.rightShoulder.isPressed && snapshot.leftTrigger.isPressed && snapshot.rightTrigger.isPressed);
    if (lrs && snapshot.buttonX.isPressed) ourValue += startValue;
    if (lrs && snapshot.dpad.right.isPressed) ourValue += selectValue;
    
    return ourValue;
    
}

- (void)startButton {
    
    CGPoint start = PAT(kPGBActionTypeStartButton);
    [[self IOSView] tapAtPoint:start];
    CGPoint okPoint = PAT(kPGBActionTypeOKDualButton);
    [[self IOSView] tapAtPoint:okPoint];
    CGPoint okSolo = PAT(kPGBActionTypeOKSoloButton);
    [[self IOSView] tapAtPoint:okSolo];
    
}



- (void)selectButton {
    
    CGPoint select = PAT(kPGBActionTypeTrainingButton);
    [[self IOSView] tapAtPoint:select];
    CGPoint cancelPoint = PAT(kPGBActionTypeOKCancelButton);
    [[self IOSView] tapAtPoint:cancelPoint];
    CGPoint closePoint = [self convertPointForScreen:CGPointMake(610,72)];
    [[self IOSView] tapAtPoint:closePoint];
    
}

- (void)handleCurrentStartSelectMode {
    NSInteger selectMode = [self selectOrStartMode];
    
    switch (selectMode) {
            
        case 1: //select
            
            [self selectButton];
            break;
            
        case 2: //startValue
            
            [self startButton];
            break;
            
        case 3: //both
            
            [self showControlEditingView];
            break;
            
        default:
            break;
    }
}

- (void)setupTapRecognizerIfNeeded {
    
    UIView *view = [self IOSView];
    NSLog(@"setupTapRecognizerIfNeeded IOSVIEW: %@", view);
    if (view != nil && _tapSetup == FALSE){
        touchSurfaceDoubleTapRecognizer = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTouchSurfaceDoubleTap:)];
        touchSurfaceDoubleTapRecognizer.numberOfTapsRequired = 3;
        [view addGestureRecognizer:touchSurfaceDoubleTapRecognizer];
        _tapSetup = TRUE;
    }
}


- (void)setupController:(GCController *)controller {
    
    //28/140 = training button
    
    UIView *view = [self IOSView];
    NSLog(@"IOSVIEW: %@", view);
    
    self.gameController = controller;
    
    [self.gameController setGateKeeper:self];
    
    GCExtendedGamepad *profile = self.gameController.extendedGamepad;
    
    self.gameController.controllerPausedHandler = ^(GCController * _Nonnull controller) {
        
        if (!self.menuVisible){
            [self showControlEditingView];
            //self.menuVisible = true;
        } else {
            
            UIViewController *rvc = [[[UIApplication sharedApplication] keyWindow] rootViewController];
            [rvc dismissViewControllerAnimated:true completion:nil];
            //self.menuVisible = false;
            
        }
        //CGPoint menu = PAT([self actionTypeForControllerButton:Menu]);
        //[[self IOSView] tapAtPoint:menu];
    };
    
    /*
     421,226 - top left
     521, 226, top right
     421, 324 - bottom left
     521, 324 - bottom right
     */
    
    
    profile.valueChangedHandler = ^(GCExtendedGamepad * _Nonnull gamepad, GCControllerElement * _Nonnull element) {
        
        
        //[self setupTapRecognizerIfNeeded];
        
        
        
    };
    
    profile.rightThumbstick.valueChangedHandler = ^(GCControllerDirectionPad * _Nonnull dpad, float xValue, float yValue) {
        
        if ([self experimentalMode]){
            CGPoint mid = CGPointMake(474,280);
            CGFloat yValueNeutral = 280;
            CGFloat xValueNeutral = 474;
            BOOL right = FALSE;
            BOOL up = FALSE;
            
            if (xValue > 0){
                right = TRUE;
            }
            
            if (yValue > 0) {
                up = TRUE;
            }
            //this means we're at neutral this is where we reset to "normal" as if no drags have ever occured
            if (xValue == 0 && yValue == 0){
                
                //NSLog(@"reset points");
                //move from previous point to joystick mid point and end all touches events.
                [self.IOSView endTouches:self.rightTouches]; //end previous touch events first
                [[self rightTouches] removeAllObjects];
                // NSArray *newtouches = [[self IOSView] dragFromPoint:mid toPoint:mid]; //move from center to center
                //[self.IOSView endTouches:newtouches]; //end those touches
                
                previousRightPoint = CGPointZero; //if previous point is zero, no joystick event is detected as being in progress
                
            } else { //either xValue or yValue != 0
                
                CGFloat xv=(xValue*80)+xValueNeutral;
                CGFloat yv=(yValue*80 * - 1)+yValueNeutral;
                
                NSLog(@"xv: %f, xy: %f", xv, yv);
                if (CGPointEqualToPoint(previousRightPoint, CGPointZero)){ //not touching down
                    
                    
                    //move from median point to x,y without touching back up
                    previousRightPoint = CGPointMake(xv, yv); //dont let the variable name fool you, this is the point we are moving to
                    //NSLog(@"first drag moving from %@ to %@", NSStringFromCGPoint(mid), NSStringFromCGPoint(previousPoint));
                    NSArray *newtouches = [self.IOSView dragFromPoint:mid toPoint:previousRightPoint];
                    if (newtouches){
                        [self.rightTouches addObjectsFromArray:newtouches];
                    }
                    
                    
                } else { //we are already touched down, we just want to move from one place to the next
                    BOOL xRegister = TRUE;
                    BOOL yRegister = TRUE;
                    
                    if (xValue > 0){
                        if (xv < previousRightPoint.x){
                            xv = previousRightPoint.x;
                        }
                    } else if (xValue < 0){
                        if (xv > previousRightPoint.x){
                            xv = previousRightPoint.x;
                        }
                    }
                    
                    NSLog(@"yvalue: %f previous y: %f", previousRightPoint.y);
                    if (yValue > 0){
                        if (yv > previousRightPoint.y){
                            yv = previousRightPoint.y;
                        }
                    } else if (yValue < 0){
                        if (yv < previousRightPoint.y){
                            yv = previousRightPoint.y;
                        }
                    }
                    
                    if (xRegister && yRegister){
                        CGPoint newPoint = CGPointMake(xv, yv);
                        
                        NSMutableArray *newTouches = [NSMutableArray new];
                        for (UITouch *updatedTouch in self.rightTouches){
                            [updatedTouch setLocationInWindow:newPoint];
                            [updatedTouch setPhaseAndUpdateTimestamp:UITouchPhaseMoved];
                            [newTouches addObject:updatedTouch];
                        }
                        
                        UIEvent *event = [self.IOSView eventWithTouches:[NSArray arrayWithArray:newTouches]];
                        [[UIApplication sharedApplication] sendEvent:event];
                        [[self rightTouches] removeAllObjects]; //remove old touches
                        if (newTouches){
                            [self.rightTouches addObjectsFromArray:newTouches];
                        }
                        
                        
                        previousRightPoint = newPoint; //update to our new point
                    }
                }
                
            }
        }
        
        
    };
    
    
    profile.leftThumbstick.valueChangedHandler = ^(GCControllerDirectionPad * _Nonnull dpad, float xValue, float yValue) {
        
        CGPoint mid = CGPointMake(104,280);
        CGFloat yValueNeutral = 280;
        CGFloat xValueNeutral = 104;
        
        //this means we're at neutral this is where we reset to "normal" as if no drags have ever occured
        if (xValue == 0 && yValue == 0){
            
            //NSLog(@"reset points");
            //move from previous point to joystick mid point and end all touches events.
            [self.IOSView endTouches:self.touches]; //end previous touch events first
            [[self touches] removeAllObjects];
            NSArray *newtouches = [[self IOSView] dragFromPoint:mid toPoint:mid]; //move from center to center
            [self.IOSView endTouches:newtouches]; //end those touches
            
            previousPoint = CGPointZero; //if previous point is zero, no joystick event is detected as being in progress
            
        } else { //either xValue or yValue != 0
            
            /**
             
             X / Y values are returned on a range from -1 to 1
             
             we want to reach a area that is 180 in diameter so we need to normalize the value
             
             280x104 is the center point of the joystick, so that is our neutral point (this is 6s specific, but
             shouldn't matter- the joystick allows you to use the whole half of the screen, the center can be
             arbitrary as long as its consistent.
             
             so xValue * 180 = the percentage we are moving the point across the plane, so we need to
             add the "neutral" value to move it up / down , left / right as necessary from the central point.
             
             */
            
            CGFloat xv=(xValue*200)+xValueNeutral;
            CGFloat yv=(yValue*200 * - 1)+yValueNeutral;
            
            /*
             
             The above values can get high unpredictable values occasionally which leads them to triggering
             other buttons on the view erroneously. This 'boxes' them into a range of values to try and prevent
             that
             
             */
            
            if (xv < 40) xv = 40;
            if (xv > 170) xv = 170;
            if (yv < 230) yv = 230;
            if (yv > 321) yv = 321;
            
            NSLog(@"xv: %f, xy: %f", xv, yv);
            if (CGPointEqualToPoint(previousPoint, CGPointZero)){ //not touching down
                
                
                //move from median point to x,y without touching back up
                previousPoint = CGPointMake(xv, yv); //dont let the variable name fool you, this is the point we are moving to
                //NSLog(@"first drag moving from %@ to %@", NSStringFromCGPoint(mid), NSStringFromCGPoint(previousPoint));
                NSArray *newtouches = [self.IOSView dragFromPoint:mid toPoint:previousPoint];
                if (newtouches){
                    [self.touches addObjectsFromArray:newtouches];
                }
                
                
            } else { //we are already touched down, we just want to move from one place to the next
                
                CGPoint newPoint = CGPointMake(xv, yv);
                //NSLog(@"PUBC: already down, moving from %@ to %@", NSStringFromCGPoint(mid),NSStringFromCGPoint(newPoint));
                /*
                 
                 Cycle through the touches we already have saved and update them to be moved to their new
                 proper location
                 
                 */
                
                NSMutableArray *newTouches = [NSMutableArray new];
                for (UITouch *updatedTouch in self.touches){
                    [updatedTouch setLocationInWindow:newPoint];
                    [updatedTouch setPhaseAndUpdateTimestamp:UITouchPhaseMoved];
                    [newTouches addObject:updatedTouch];
                }
                
                UIEvent *event = [self.IOSView eventWithTouches:[NSArray arrayWithArray:newTouches]];
                [[UIApplication sharedApplication] sendEvent:event];
                [[self touches] removeAllObjects]; //remove old touches
                if (newTouches){
                    [self.touches addObjectsFromArray:newTouches];
                }
                
                
                previousPoint = newPoint; //update to our new point
            }
            
        }
        
        
        
    };
    
    //L3/R3 are API specific, but since i do the lazy category above to add this to everything, respondsToSelector wouldn't be sufficient.
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"12.1")){
        
        profile.leftThumbstickButton.valueChangedHandler = ^(GCControllerButtonInput * _Nonnull button, float value, BOOL pressed) {
            
            if (pressed){
                
                CGPoint hand = PAT([self actionTypeForControllerButton:LeftThumbstickButton]);//PAT(kPGBActionHandAction);
                [[self IOSView] tapAtPoint:hand];
            }
            
        };
        
        profile.rightThumbstickButton.valueChangedHandler = ^(GCControllerButtonInput * _Nonnull button, float value, BOOL pressed) {
            
            if (pressed){
                
                CGPoint first = PAT([self actionTypeForControllerButton:RightThumbstickButton]);//PAT(kPGBActionFirstItemSelect);
                [[self IOSView] tapAtPoint:first];
            }
            
        };
    }
    
    profile.dpad.valueChangedHandler = ^(GCControllerDirectionPad * _Nonnull dpad, float xValue, float yValue) {
        
        if (dpad.down.isPressed){
            //NSLog(@"down");
            CGPoint reload = PAT([self actionTypeForControllerButton:DpadDown]);//PAT(kPGBActionTypeReload);
            [[self IOSView] tapAtPoint:reload];
            
        }
        
        if (dpad.left.isPressed){
            CGPoint leftWeapon = PAT([self actionTypeForControllerButton:DpadLeft]);
            //NSLog(@"left");
            [[self IOSView] tapAtPoint:leftWeapon];
        }
        
        if (dpad.up.isPressed){
            //NSLog(@"up");
            CGPoint aim = PAT([self actionTypeForControllerButton:DpadUp]);//PAT(kPGBActionTypeAim);
            [[self IOSView] tapAtPoint:aim];
        }
        
        if (dpad.right.isPressed && [self selectOrStartMode] == 0){
            //NSLog(@"right");
            CGPoint rightWeapon = PAT([self actionTypeForControllerButton:DpadRight]);//PAT(kPGBActionTypeSecondWeapon);
            [[self IOSView] tapAtPoint:rightWeapon];
        }
        
        
    };
    
    profile.leftShoulder.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        
        if (pressed && [self selectOrStartMode] == 0){
            
            CGPoint training = PAT([self actionTypeForControllerButton:LeftShoulder]);
            [[self IOSView] tapAtPoint:training];
       
        } else if (pressed && [self selectOrStartMode] != 0){
            
            [self handleCurrentStartSelectMode]; //only need to do it in one place.
            
        }
    };
    
    profile.rightShoulder.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed && [self selectOrStartMode] == 0){
            CGPoint start = PAT([self actionTypeForControllerButton:RightShoulder]);
            [[self IOSView] tapAtPoint:start];
            
        }
    };
    
    __block UITouch *currentRightTouch = nil;
    profile.rightTrigger.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed && [self selectOrStartMode] == 0){
            // NSLog(@"rightTrigger");
            CGPoint punchRight = PAT([self actionTypeForControllerButton:RightTrigger]);//PAT(kPGBActionTypeRight);
            if (currentRightTouch){
                [[self IOSView] finishTouch:currentRightTouch];
                currentRightTouch = nil;
            }
            currentRightTouch = [[self IOSView] tapDownAtPoint:punchRight];
        } else if (!pressed){
            
            if (currentRightTouch) {
                [[self IOSView] finishTouch:currentRightTouch];
                currentRightTouch = nil;
            }
        }
    };
    
    __block UITouch *currentLeftTouch = nil;
    profile.leftTrigger.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        
        if (pressed && [self selectOrStartMode] == 0) {
            //NSLog(@"leftTrigger");
            CGPoint punchLeft = PAT([self actionTypeForControllerButton:LeftTrigger]);//PAT(kPGBActionTypeLeft);
            currentLeftTouch = [[self IOSView] tapDownAtPoint:punchLeft];
        } else if (!pressed){
            
            if (currentLeftTouch) {
                [[self IOSView] finishTouch:currentLeftTouch];
                currentLeftTouch = nil;
            }
        }
    };
    
    __block UITouch *jumpTouch = nil;
    profile.buttonA.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed)
        {
            //NSLog(@"ButtonA");
            CGPoint jump = PAT([self actionTypeForControllerButton:ButtonA]);
            jumpTouch =  [[self IOSView] tapDownAtPoint:jump];
        } else {
            if (jumpTouch) {
                [[self IOSView] finishTouch:jumpTouch];
                jumpTouch = nil;
            }
            
        }
    };
    
    
    profile.buttonB.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed)
        {
            //NSLog(@"ButtonB");
            CGPoint laydown = PAT([self actionTypeForControllerButton:ButtonB]);//PAT(kPGBActionTypeConceal);
            [[self IOSView] tapAtPoint:laydown];
        }
    };
    
    profile.buttonX.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if(pressed && [self selectOrStartMode] == 0)
        {
            //NSLog(@"buttonX");
            CGPoint run = PAT([self actionTypeForControllerButton:ButtonX]);////PAT(kPGBActionTypeRun);
            [[self IOSView] tapAtPoint:run];
        }
    };
    
    profile.buttonY.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed)
        {
            //NSLog(@"buttonY");
            CGPoint crouch = PAT([self actionTypeForControllerButton:ButtonY]);//PAT(kPGBActionTypeCrouch);
            [[self IOSView] tapAtPoint:crouch];
            
        }
    };
    
}

- (void)controllerConnected:(NSNotification *)n {
    
    [self setupController:n.object];
    
    
}

- (PGBActionType)actionTypeFromConstant:(NSString *)constant {
    
    PGBActionType type = kPGBActionTypeUndefined;
    if ([constant isEqualToString:PGBActionTypeAim]){
        type = kPGBActionTypeAim;
    } else if ([constant isEqualToString:PGBActionTypeRun]){
        type = kPGBActionTypeRun;
    } else if ([constant isEqualToString:PGBActionTypeConceal]){
        type = kPGBActionTypeConceal;
    } else if ([constant isEqualToString:PGBActionTypeReload]){
        type = kPGBActionTypeReload;
    } else if ([constant isEqualToString:PGBActionTypeFirstWeapon]){
        type = kPGBActionTypeFirstWeapon;
    } else if ([constant isEqualToString:PGBActionTypeSecondWeapon]){
        type = kPGBActionTypeSecondWeapon;
    } else if ([constant isEqualToString:PGBActionTypeTrainingButton]){
        type = kPGBActionTypeTrainingButton;
    } else if ([constant isEqualToString:PGBActionTypeOKCancelButton]){
        type = kPGBActionTypeOKCancelButton;
    } else if ([constant isEqualToString:PGBActionTypeXCloseButton]){
        type = kPGBActionTypeXCloseButton;
    } else if ([constant isEqualToString:PGBActionTypeStartButton]){
        type = kPGBActionTypeStartButton;
    } else if ([constant isEqualToString:PGBActionTypeOKDualButton]){
        type = kPGBActionTypeOKDualButton;
    } else if ([constant isEqualToString:PGBActionTypeXClose2Button]){
        type = kPGBActionTypeXClose2Button;
    } else if ([constant isEqualToString:PGBActionTypeRight]){
        type = kPGBActionTypeRight;
    } else if ([constant isEqualToString:PGBActionTypeLeft]){
        type = kPGBActionTypeLeft;
    } else if ([constant isEqualToString:PGBActionTypeJump]){
        type = kPGBActionTypeJump;
    } else if ([constant isEqualToString:PGBActionTypeCrouch]){
        type = kPGBActionTypeCrouch;
    } else if ([constant isEqualToString:PGBActionTypeSmallWeapon]){
        type = kPGBActionTypeSmallWeapon;
    } else if ([constant isEqualToString:PGBActionTypeExitRound]){
        type = kPGBActionTypeExitRound;
    } else if ([constant isEqualToString:PGBActionHandAction]){
        type = kPGBActionHandAction;
    } else if ([constant isEqualToString:PGBActionTypeInventory]){
        type = kPGBActionTypeInventory;
    } else if ([constant isEqualToString:PGBActionFirstItemSelect]){
        type = kPGBActionFirstItemSelect;
    } else if ([constant isEqualToString:PGBActionTypeOKSoloButton]){
        type = kPGBActionTypeOKSoloButton;
    } else if ([constant isEqualToString:PGBActionTypePeakLeft]){
        type = kPGBActionTypePeakLeft;
    }  else if ([constant isEqualToString:PGBActionTypePeakRight]){
        type = kPGBActionTypePeakRight;
    }
    return type;
    
}

/**
 
 Controller mapping, this will take controller map button constant (ie ButtonA)
 and map it to its corresponding action type ie kPGBActionTypeRun. This is
 how the controller mapping gets customized to the values in our preferences plist.
 
 */

- (PGBActionType)actionTypeForControllerButton:(NSString *)constantString {
    
    NSDictionary *controllerDictionary = [self controllerPreferences];
    NSString *controllerValue = controllerDictionary[constantString];
    return [self actionTypeFromConstant:controllerValue];
}

/**
 
 For now certain devices will get special treatment like this until i figure out a better solution.
 
 This receives an action type (ie kPGBActionTypeRun) and translates it to a hardcoded value offset
 on the desired device screen. This is specific for the iPad Pro 9.7, not sure if this will be
 able to be used to translate to other ipads or not yet.
 
 
 */

- (CGPoint)pointForActionTypeOnIPadPro97:(PGBActionType)type {
    
    CGPoint outpoint = CGPointZero;
    switch (type) {
        case kPGBActionTypeAim:
            outpoint = CGPointMake(982,503);
            break;
            
        case kPGBActionTypeRun:
            outpoint = CGPointMake(863, 135);
            break;
            
        case kPGBActionTypeConceal: //lay down
            outpoint = CGPointMake(947, 730);
            break;
            
        case kPGBActionTypeReload:
            outpoint = CGPointMake(793,730);
            break;
            
        case kPGBActionTypeFirstWeapon:
            outpoint = CGPointMake(441,712);
            break;
            
        case kPGBActionTypeSecondWeapon:
            outpoint = CGPointMake(582, 712);
            break;
            
        case kPGBActionTypeTrainingButton:
            outpoint = CGPointZero; //dont have this value yet
            break;
            
        case kPGBActionTypeOKCancelButton:    //Cancel button (on ok/cancel alert)
            outpoint = CGPointZero; //dont have this value yet
            break;
            
        case kPGBActionTypeXCloseButton:  //top right close x
            outpoint = CGPointZero; //dont have this value yet
            break;
            
        case kPGBActionTypeStartButton:
            outpoint = CGPointMake(81, 32);
            break;
            
        case kPGBActionTypeOKDualButton: //(point for OK on Cancel / OK alert)
            outpoint = CGPointZero; //dont have this value yet
            break;
            
        case kPGBActionTypeXClose2Button: //lower close X
            outpoint = CGPointZero; //dont have this value yet
            break;
            
            
            
        case kPGBActionTypeRight:
            outpoint = CGPointMake(875, 631);
            break;
            
        case kPGBActionTypeLeft:
            outpoint = CGPointMake(61,389);
            break;
            
        case kPGBActionTypeJump:
            outpoint = CGPointMake(983,587); //long press
            break;
            
        case kPGBActionTypeCrouch:
            outpoint = CGPointMake(876, 730);
            break;
        case kPGBActionTypeSmallWeapon:
            outpoint = CGPointZero; //dont have this value yet
            break;
            
        case kPGBActionTypeExitRound:
            outpoint = CGPointMake(64,13);
            break;
            
            
            /*
             weapon option 1 = (441, 680)
             weapon options 2 = (582, 680)
             first item - (716, 188)
             
             */
            
        case kPGBActionTypeInventory:
            outpoint =  CGPointMake(70,713);
            break;
            
        case kPGBActionHandAction:
            outpoint = CGPointMake(748, 146);
            break;
            
        case kPGBActionFirstItemSelect:
            outpoint = CGPointMake(716, 188);// y+50 = 2 item y+ 100 = 3rd item
            break;
            
        case kPGBActionTypeOKSoloButton:
            outpoint = CGPointZero; //dont have this value yet
            break;
            
        case kPGBActionTypePeakLeft:
            outpoint = CGPointZero; //dont have this value yet
            break;
            
        case kPGBActionTypePeakRight:
            outpoint = CGPointZero; //dont have this value yet
            break;
            
        default:
            break;
    }
    return outpoint;
    
}

/**
 
 All devices pass through here to get the actual action -> CGPoint mapping
 of where to simulate the touch event, all the values are mapped to the 6s
 screen, but then I attempt to translate the button offset to other screen sizes
 it works for a decent amount of models, but not all. still needs work.
 
 */

- (CGPoint)pointForActionType:(PGBActionType)type {
    
    NSArray *ipad97 = @[@"iPad6,3",@"iPad6,4"];
    if ([ipad97 containsObject:[self machine]]){
        
        return [self pointForActionTypeOnIPadPro97:type];
    }
    
    CGPoint outpoint = CGPointZero;
    
    switch (type) {
        case kPGBActionTypeAim:
            outpoint = [self convertPointForScreen:CGPointMake(641,197)];
            break;
            
        case kPGBActionTypeRun:
            outpoint = [self convertPointForScreen:CGPointMake(558, 99)];
            break;
            
        case kPGBActionTypeConceal: //lay down
            outpoint = [self convertPointForScreen:CGPointMake(617, 345)];
            break;
            
        case kPGBActionTypeReload:
            outpoint = [self convertPointForScreen:CGPointMake(508,353)];
            break;
            
        case kPGBActionTypeFirstWeapon:
            outpoint = [self convertPointForScreen:CGPointMake(290,340)];
            break;
            
        case kPGBActionTypeSecondWeapon:
            outpoint = [self convertPointForScreen:CGPointMake(376,340)];
            break;
            
        case kPGBActionTypeTrainingButton:
            outpoint = [self convertPointForScreen:CGPointMake(28, 140)];
            break;
            
        case kPGBActionTypeOKCancelButton:    //Cancel button (on ok/cancel alert)
            outpoint = [self convertPointForScreen:CGPointMake(281,266)];
            break;
            
        case kPGBActionTypeXCloseButton:  //top right close x
            outpoint = [self convertPointForScreen:CGPointMake(610,72)];
            break;
            
        case kPGBActionTypeStartButton:
            outpoint = [self convertPointForScreen:CGPointMake(81, 32)];
            break;
            
        case kPGBActionTypeOKDualButton: //(point for OK on Cancel / OK alert)
            outpoint = [self convertPointForScreen:CGPointMake(388,266)];
            break;
            
        case kPGBActionTypeXClose2Button: //lower close X
            outpoint = [self convertPointForScreen:CGPointMake(627,31)];
            break;
            
        case kPGBActionTypeRight:
            outpoint = [self convertPointForScreen:CGPointMake(565, 275)];
            break;
            
        case kPGBActionTypeLeft:
            outpoint = [self convertPointForScreen:CGPointMake(39, 198)];
            break;
            
        case kPGBActionTypeJump:
            outpoint = [self convertPointForScreen:CGPointMake(639, 258)]; //long press
            break;
            
        case kPGBActionTypeCrouch:
            outpoint = [self convertPointForScreen:CGPointMake(560, 349)];
            break;
        case kPGBActionTypeSmallWeapon:
            outpoint = [self convertPointForScreen:CGPointMake(406,313)];
            break;
            
        case kPGBActionTypeExitRound:
            outpoint = [self convertPointForScreen:CGPointMake(64,13)];
            break;
            
        case kPGBActionTypeInventory:
            outpoint =  [self convertPointForScreen:CGPointMake(48, 343)];
            break;
            
        case kPGBActionHandAction:
            outpoint = [self convertPointForScreen:CGPointMake(480,95)];
            break;
            
        case kPGBActionFirstItemSelect:
            outpoint = [self convertPointForScreen:CGPointMake(437,132)];// y+50 = 2 item y+ 100 = 3rd item
            break;
            
        case kPGBActionTypeOKSoloButton:
            outpoint = [self convertPointForScreen:CGPointMake(330,266)];
            break;
            
        case kPGBActionTypePeakLeft:
            outpoint = [self convertPointForScreen:CGPointMake(91,139)];
            break;
            
        case kPGBActionTypePeakRight:
            outpoint = [self convertPointForScreen:CGPointMake(144,139)];
            break;
            
        default:
            break;
    }
    return outpoint;
    
}

@end
