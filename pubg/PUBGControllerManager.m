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

@end

@implementation PUBGControllerManager

@synthesize previousPoint;

+ (id)sharedManager
{
    static dispatch_once_t onceToken;
    
    static PUBGControllerManager *shared = nil;
    if(shared == nil)
    {
        dispatch_once(&onceToken, ^{
            shared = [[PUBGControllerManager alloc] init];
            shared.touches = [NSMutableArray new];
        });
    }
    return shared;
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

- (NSDictionary *)controllerPreferences {
    
    /* TODO: this will require the game is reloaded for any changes made to the controller layout,
     should get this working through defaults somehow - but at that point it should have a preference loader bundle
     */
    if (self.gamePlayDictionary == nil){
        NSString *preferenceFile = @"/var/mobile/Library/Preferences/com.nito.pubc.plist";
        
        self.gamePlayDictionary = [NSDictionary dictionaryWithContentsOfFile:preferenceFile];
        //NSLog(@"gameplay dict: %@", self.gamePlayDictionary);
    }
    return self.gamePlayDictionary;
}

/**
 
 IOSView (of class type FIOSView) is the main root view being displayed at all times in pubg
 that is where we need to route all touch events, there is a reference to it in
 IOSAppDelegate (the main app delegate class for pubg).
 
 */

- (UIView *)IOSView {
    
    return [(IOSAppDelegate*)[[UIApplication sharedApplication] delegate] valueForKey:@"IOSView"];
    
}

- (void)listenForControllers {
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controllerConnected:) name:GCControllerDidConnectNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controllerDisconnected:) name:GCControllerDidDisconnectNotification object:nil];
}

/**
 
 Take the MFI controller that was detected and add valueChangedHandlers. These allow me to listen for button
 presses and simulate touch events to to correspond to how a user would press a button on the screen.
 
 */

- (void)setupController:(GCController *)controller {
    
    //28/140 = training button
    self.gameController = controller;
    
    GCExtendedGamepad *profile = self.gameController.extendedGamepad;
    
    self.gameController.controllerPausedHandler = ^(GCController * _Nonnull controller) {
        
        NSLog(@"### pause button??");
        
        CGPoint menu = PAT([self actionTypeForControllerButton:Menu]);
        [[self IOSView] tapAtPoint:menu];
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
                NSLog(@"first drag moving from %@ to %@", NSStringFromCGPoint(mid), NSStringFromCGPoint(previousPoint));
                NSArray *newtouches = [self.IOSView dragFromPoint:mid toPoint:previousPoint];
                if (newtouches){
                    [self.touches addObjectsFromArray:newtouches];
                }
                
        
            } else { //we are already touched down, we just want to move from one place to the next
                
                //This doesn't appear to work properly, i wonder if we need to end previous touch events first and THEN move it? i dont know.
                
                CGPoint newPoint = CGPointMake(xv, yv);
                NSLog(@"PUBC: already down, moving from %@ to %@", NSStringFromCGPoint(mid),NSStringFromCGPoint(newPoint));
                
                //NSLog(@"last touch: %@", self.touches.lastObject);
                NSMutableArray *newTouches = [NSMutableArray new];
                for (UITouch *updatedTouch in self.touches){
                        [updatedTouch setLocationInWindow:newPoint];
                        [updatedTouch setPhaseAndUpdateTimestamp:UITouchPhaseMoved];
                        [newTouches addObject:updatedTouch];
                }
                
                UIEvent *event = [self.IOSView eventWithTouches:[NSArray arrayWithArray:newTouches]];
                [[UIApplication sharedApplication] sendEvent:event];
                [[self touches] removeAllObjects];
                if (newTouches){
                    [self.touches addObjectsFromArray:newTouches];
                }
            
                /*
                NSArray *newtouches = [self.IOSView moveFromPoint:previousPoint toPoint:newPoint];
                if (newtouches){
                    [self.touches addObjectsFromArray:newtouches];
                }*/
                previousPoint = newPoint;
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
            NSLog(@"down");
            CGPoint reload = PAT([self actionTypeForControllerButton:DpadDown]);//PAT(kPGBActionTypeReload);
            [[self IOSView] tapAtPoint:reload];
            
        }
        
        if (dpad.left.isPressed){
            CGPoint leftWeapon = PAT([self actionTypeForControllerButton:DpadLeft]);
            NSLog(@"left");
            [[self IOSView] tapAtPoint:leftWeapon];
        }
        
        if (dpad.up.isPressed){
            NSLog(@"up");
            CGPoint aim = PAT([self actionTypeForControllerButton:DpadUp]);//PAT(kPGBActionTypeAim);
            [[self IOSView] tapAtPoint:aim];
        }
        
        if (dpad.right.isPressed){
            NSLog(@"right");
            CGPoint rightWeapon = PAT([self actionTypeForControllerButton:DpadRight]);//PAT(kPGBActionTypeSecondWeapon);
            [[self IOSView] tapAtPoint:rightWeapon];
        }
        
        
    };
    
    profile.leftShoulder.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed){
            NSLog(@"leftShoulder");
            CGPoint training = PAT([self actionTypeForControllerButton:LeftShoulder]);//PAT(kPGBActionTypeTrainingButton);
            [[self IOSView] tapAtPoint:training];
            
            //NSLog(@"ios view: %@", [self IOSView]);
            CGPoint cancelPoint = PAT(kPGBActionTypeOKCancelButton);
            [[self IOSView] tapAtPoint:cancelPoint];
            
            CGPoint closePoint = [self convertPointForScreen:CGPointMake(610,72)];
            [[self IOSView] tapAtPoint:closePoint];
            
        }
    };
    
    profile.rightShoulder.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed){
            NSLog(@"rightShoulder");
            CGPoint start = PAT([self actionTypeForControllerButton:RightShoulder]);//PAT(kPGBActionTypeStartButton);
            [[self IOSView] tapAtPoint:start];
            
            CGPoint okPoint = PAT(kPGBActionTypeOKDualButton);
            [[self IOSView] tapAtPoint:okPoint];
            
            CGPoint okSolo = PAT(kPGBActionTypeOKSoloButton);
            [[self IOSView] tapAtPoint:okSolo];
            
            //CGPoint closePoint = PAT(kPGBActionTypeXCloseButton);
            //[[self IOSView] tapAtPoint:closePoint];
            
            //CGPoint cancelPoint2 = [self convertPointForScreen:CGPointMake(610,72)];
            //[[self IOSView] tapAtPoint:cancelPoint2];
            
        }
    };
    
    __block UITouch *currentRightTouch = nil;
    profile.rightTrigger.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed){
                 NSLog(@"rightTrigger");
            CGPoint punchRight = PAT([self actionTypeForControllerButton:RightTrigger]);//PAT(kPGBActionTypeRight);
            if (currentRightTouch){
                [[self IOSView] finishTouch:currentRightTouch];
                currentRightTouch = nil;
            }
            currentRightTouch = [[self IOSView] tapDownAtPoint:punchRight];
        } else {
            
            if (currentRightTouch) {
                [[self IOSView] finishTouch:currentRightTouch];
                currentRightTouch = nil;
            }
        }
    };
    
    __block UITouch *currentLeftTouch = nil;
    profile.leftTrigger.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        
        if (pressed)
        {
            NSLog(@"leftTrigger");
            CGPoint punchLeft = PAT([self actionTypeForControllerButton:LeftTrigger]);//PAT(kPGBActionTypeLeft);
            currentLeftTouch = [[self IOSView] tapDownAtPoint:punchLeft];
        } else {
            
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
            NSLog(@"ButtonA");
            CGPoint jump = PAT([self actionTypeForControllerButton:ButtonA]);//PAT(kPGBActionTypeJump);
            //jumpTouch = [[self IOSView] longPressAtPoint: jump duration: .1];
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
            NSLog(@"ButtonB");
            CGPoint laydown = PAT([self actionTypeForControllerButton:ButtonB]);//PAT(kPGBActionTypeConceal);
            [[self IOSView] tapAtPoint:laydown];
        }
    };
    
    profile.buttonX.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed)
        {
            NSLog(@"buttonX");
            CGPoint run = PAT([self actionTypeForControllerButton:ButtonX]);////PAT(kPGBActionTypeRun);
            [[self IOSView] tapAtPoint:run];
        }
    };
    
    profile.buttonY.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed)
        {
            NSLog(@"buttonY");
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
