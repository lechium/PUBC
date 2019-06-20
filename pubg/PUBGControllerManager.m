//
//  PUBGControllerManager.m
//  nitoTV4
//
//  Created by Kevin Bradley on 6/15/19.
//  Copyright © 2019 nito. All rights reserved.
//

#import "PUBGControllerManager.h"
#import <GameController/GameController.h>
#import "UIView-KIFAdditions.h"

#include <sys/sysctl.h>

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define PAT(x) [self pointForActionType:x]
#define DLog(format, ...) CFShow((__bridge CFStringRef)[NSString stringWithFormat:format, ## __VA_ARGS__]);
#define LOG_SELF        NSLog(@"%@ %@", self, NSStringFromSelector(_cmd))
#define DLOG_SELF DLog(@"%@ %@", self, NSStringFromSelector(_cmd))

@interface GCExtendedGamepad (science)

@property (nonatomic,readonly) GCControllerButtonInput * leftThumbstickButton;
@property (nonatomic,readonly) GCControllerButtonInput * rightThumbstickButton;

@end

@interface IOSAppDelegate : UIResponder <UIApplicationDelegate, UITextFieldDelegate>

@property(retain) UIView *IOSView; // @synthesize IOSView;

@end


@interface PUBGControllerManager ()

@property (readwrite, assign) CGPoint previousPoint;
@property (nonatomic, strong) NSMutableArray *touches;

@end

@implementation PUBGControllerManager

@synthesize previousPoint;

- (NSString *)machine {
    
    size_t size;
    sysctlbyname("hw.machine", NULL, &size, NULL, 0);
    char *machine = malloc(size);
    sysctlbyname("hw.machine", machine, &size, NULL, 0);
    return [NSString stringWithCString:machine encoding:NSUTF8StringEncoding];
    
}

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

+ (id)sharedManager
{
    LOG_SELF;
    static dispatch_once_t onceToken;
    
    static PUBGControllerManager *shared = nil;
    if(shared == nil)
    {
        dispatch_once(&onceToken, ^{
            shared = [[PUBGControllerManager alloc] init];
            shared.touches = [NSMutableArray new];
            //[shared listenForControllers];
        });
    }
    return shared;
}

- (NSDictionary *)controllerPreferences {
    
    if (self.gamePlayDictionary == nil){
        NSString *preferenceFile = @"/var/mobile/Library/Preferences/com.nito.pubc.plist";
        self.gamePlayDictionary = [NSDictionary dictionaryWithContentsOfFile:preferenceFile];
        //NSLog(@"gameplay dict: %@", self.gamePlayDictionary);
    }
    return self.gamePlayDictionary;
}

- (UIView *)IOSView {
    
    return [(IOSAppDelegate*)[[UIApplication sharedApplication] delegate] valueForKey:@"IOSView"];
    
}

- (void)listenForControllers {
    
    LOG_SELF;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controllerConnected:) name:GCControllerDidConnectNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controllerDisconnected:) name:GCControllerDidDisconnectNotification object:nil];
    
}

- (void)setupController:(GCController *)controller {
    
    LOG_SELF;
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
        
        
        if (xValue == 0 && yValue == 0){
            
            //NSLog(@"reset points");
            //move from previous point to median point and end all touches events.
            [self.IOSView endTouches:self.touches];
            NSArray *newtouches = [[self IOSView] dragFromPoint:mid toPoint:mid];
            [self.IOSView endTouches:newtouches];
            
            previousPoint = CGPointZero;
            
        } else {
            CGFloat xv=(xValue*180)+xValueNeutral;
            CGFloat yv=(yValue*180 * - 1)+yValueNeutral;
            
            if (xv < 40) xv = 40;
            if (xv > 170) xv = 170;
            if (yv < 230) yv = 230;
            if (yv > 321) yv = 321;
            
            NSLog(@"xv: %f, xy: %f", xv, yv);
            if (CGPointEqualToPoint(previousPoint, CGPointZero)){ //not touching down
                
                
                //move from median point to x,y without touching back up.. maybe keep track of all the touches?
                previousPoint = CGPointMake(xv, yv);
                NSLog(@"first drag moving from %@ to %@", NSStringFromCGPoint(mid), NSStringFromCGPoint(previousPoint));
                NSArray *newtouches = [self.IOSView dragFromPoint:mid toPoint:previousPoint];
                if (newtouches){
                    [self.touches addObjectsFromArray:newtouches];
                }
                
                
                
                
            } else { //we are already touched down, we just want to move from one place to the next
                
                
                CGPoint newPoint = CGPointMake(xv, yv);
                NSLog(@"already down, moving from %@ to %@", NSStringFromCGPoint(mid),NSStringFromCGPoint(newPoint));
                NSArray *newtouches = [self.IOSView dragFromPoint:previousPoint toPoint:newPoint];
                if (newtouches){
                    [self.touches addObjectsFromArray:newtouches];
                }
                previousPoint = newPoint;
            }
            
        }
        
        
        
    };
    
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
            CGPoint reload = PAT([self actionTypeForControllerButton:DpadDown]);//PAT(kPGBActionTypeReload);
            [[self IOSView] tapAtPoint:reload];
            
        }
        
        if (dpad.left.isPressed){
            CGPoint leftWeapon = PAT([self actionTypeForControllerButton:DpadLeft]);//PAT(kPGBActionTypeFirstWeapon);
            [[self IOSView] tapAtPoint:leftWeapon];
        }
        
        if (dpad.up.isPressed){
            CGPoint aim = PAT([self actionTypeForControllerButton:DpadUp]);//PAT(kPGBActionTypeAim);
            [[self IOSView] tapAtPoint:aim];
        }
        
        if (dpad.right.isPressed){
            CGPoint rightWeapon = PAT([self actionTypeForControllerButton:DpadRight]);//PAT(kPGBActionTypeSecondWeapon);
            [[self IOSView] tapAtPoint:rightWeapon];
        }
        
        
    };
    
    profile.leftShoulder.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed){
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
            CGPoint laydown = PAT([self actionTypeForControllerButton:ButtonB]);//PAT(kPGBActionTypeConceal);
            [[self IOSView] tapAtPoint:laydown];
        }
    };
    
    profile.buttonX.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed)
        {
            CGPoint run = PAT([self actionTypeForControllerButton:ButtonX]);////PAT(kPGBActionTypeRun);
            [[self IOSView] tapAtPoint:run];
        }
    };
    
    profile.buttonY.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed)
        {
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


- (PGBActionType)actionTypeForControllerButton:(NSString *)constantString {
    
    NSDictionary *controllerDictionary = [self controllerPreferences];
    NSString *controllerValue = controllerDictionary[constantString];
    return [self actionTypeFromConstant:controllerValue];
}

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
