#import <GameController/GameController.h>
#import "NSObject+AssociatedObjects.h"
#import "UIView-KIFAdditions.h"
//static GCController* gameController = nil; //Dictionary{index:STTouch}

static NSString * const PGBActionTypeLeft = @"PGBActionTypeLeft";
static NSString * const PGBActionTypeRight = @"PGBActionTypeRight";
static NSString * const PGBActionTypeRun = @"PGBActionTypeRun";
static NSString * const PGBActionTypeCrouch = @"PGBActionTypeCrouch";
static NSString * const PGBActionTypeConceal = @"PGBActionTypeConceal";
static NSString * const PGBActionTypeJump = @"PGBActionTypeJump";
static NSString * const PGBActionTypeFirstWeapon = @"PGBActionTypeFirstWeapon";
static NSString * const PGBActionTypeSecondWeapon = @"PGBActionTypeSecondWeapon";
static NSString * const PGBActionTypeSmallWeapon = @"PGBActionTypeSmallWeapon";
static NSString * const PGBActionTypeAim = @"PGBActionTypeAim";
static NSString * const PGBActionTypeReload = @"PGBActionTypeReload";
static NSString * const PGBActionTypeExitRound = @"PGBActionTypeExitRound";
static NSString * const PGBActionTypeOKCancelButton = @"PGBActionTypeOKCancelButton";
static NSString * const PGBActionTypeXCloseButton = @"PGBActionTypeXCloseButton";
static NSString * const PGBActionTypeXClose2Button = @"PGBActionTypeXClose2Button";
static NSString * const PGBActionTypeOKDualButton = @"PGBActionTypeOKDualButton";
static NSString * const PGBActionTypeOKSoloButton = @"PGBActionTypeOKSoloButton";
static NSString * const PGBActionTypeInventory = @"PGBActionTypeInventory";
static NSString * const PGBActionHandAction = @"PGBActionHandAction";
static NSString * const PGBActionFirstItemSelect = @"PGBActionFirstItemSelect";
static NSString * const PGBActionMapAction = @"PGBActionMapAction";
static NSString * const PGBActionTypeTrainingButton = @"PGBActionTypeTrainingButton";
static NSString * const PGBActionTypeStartButton = @"PGBActionTypeStartButton";

static NSString * const LeftThumbstick = @"LeftThumbstick";
static NSString * const RightThumbstick = @"RightThumbstick";
static NSString * const LeftThumbstickButton = @"LeftThumbstickButton";
static NSString * const RightThumbstickButton = @"RightThumbstickButton";
static NSString * const ButtonA = @"ButtonA";
static NSString * const ButtonB = @"ButtonB";
static NSString * const ButtonX = @"ButtonX";
static NSString * const ButtonY = @"ButtonY";
static NSString * const DpadUp = @"Dpad.up";
static NSString * const DpadDown = @"Dpad.down";
static NSString * const DpadLeft = @"Dpad.left";
static NSString * const DpadRight = @"Dpad.right";

typedef enum {
    
    kPGBActionTypeLeft,
    kPGBActionTypeRight,
    kPGBActionTypeRun,
    kPGBActionTypeCrouch,
    kPGBActionTypeConceal,
    kPGBActionTypeJump,
    kPGBActionTypeFirstWeapon,
    kPGBActionTypeSecondWeapon,
    kPGBActionTypeSmallWeapon,
    kPGBActionTypeAim,
    kPGBActionTypeReload,
    kPGBActionTypeExitRound,
    kPGBActionTypeOKCancelButton,
    kPGBActionTypeXCloseButton,
    kPGBActionTypeXClose2Button,
    kPGBActionTypeOKDualButton,
    kPGBActionTypeOKSoloButton,
    kPGBActionTypeInventory,
    kPGBActionHandAction,
    kPGBActionFirstItemSelect,
    kPGBActionMapAction,
    kPGBActionTypeTrainingButton,
    kPGBActionTypeStartButton,
    kPGBActionTypeUndefined,
    
} PGBActionType;

@interface GCExtendedGamepad (science)

@property (nonatomic,readonly) GCControllerButtonInput * leftThumbstickButton; 
@property (nonatomic,readonly) GCControllerButtonInput * rightThumbstickButton; 

@end

@interface IOSAppDelegate : UIResponder <UIApplicationDelegate, UITextFieldDelegate>

@property(retain) UIView *IOSView; // @synthesize IOSView;
- (CGPoint)convertPointForScreen:(CGPoint)inputPoint;
- (CGPoint)pointForActionType:(PGBActionType)type;
@end
/*
@interface IOSAppDelegate (pubg)

@property (nonatomic) GCController *gameController;

@end

@implementation IOSAppDelegate (ButtonConvenience)

- (void)setGameController:(GCController *)gameController
{
    [self associateValue:gameController withKey:@selector(gameController)];
}

- (GCController *)gameController
{
    return [self associatedValueForKey:@selector(gameController)];
}

@end
*/

#define SCREEN_WIDTH [[UIScreen mainScreen] bounds].size.width
#define SCREEN_HEIGHT [[UIScreen mainScreen] bounds].size.height
#define PAT(x) [self pointForActionType:x]

#define degreesToRadians(x) (M_PI * (x) / 180.0)

%hook IOSAppDelegate

%new - (PGBActionType)actionTypeFromConstant:(NSString *)constant {
    
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
    }

    return type;
    
}

%new - (CGPoint)pointForActionType:(PGBActionType)type {
    
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
        
        default:
            break;
    }
    return outpoint;
    
}

%new - (CGPoint)convertPointForScreen:(CGPoint)inputPoint {

    if (SCREEN_HEIGHT == 667) {
        return inputPoint;
    }
    //x = (OG_VALUE * TARGET_WIDTH) / OG_WIDTH;
    //y = (OG_VALUE * TARGET_HEIGHT / OG_HEIGHT;
    CGFloat x = (inputPoint.x * SCREEN_WIDTH) / 667;
    CGFloat y = (inputPoint.y * SCREEN_HEIGHT) / 375;

    return CGPointMake(x, y);
}

static CGFloat lastXMove;
static CGFloat lastYMove;
static UITouch *lastXTouch;
static UITouch *lastYTouch;

%new - (void)controllerConnected:(NSNotification *)n {
    
    GCController *gameController = n.object;
    //28/140 = training button
    GCExtendedGamepad *profile = gameController.extendedGamepad;
    
    __block NSArray <UITouch *> *touches = nil;

    [profile.leftThumbstick.xAxis setValueChangedHandler:^(GCControllerAxisInput *axis, float value) {
				NSInteger v=(NSInteger)(value*127); //-127 ... + 127 range

				if (v != 0){
				    NSLog(@"Joy X: %i", v);
                }
	}];
	[profile.leftThumbstick.yAxis setValueChangedHandler:^(GCControllerAxisInput *axis, float value) {
				NSInteger v= (NSInteger)(value*127 * - 1); //-127 ... + 127 range

                if (v != 0){
				    NSLog(@"Joy Y: %i", v);
                }
	}];
    
    profile.leftThumbstick.valueChangedHandler = ^(GCControllerDirectionPad * _Nonnull dpad, float xValue, float yValue) {
        
        
        CGPoint mid = CGPointMake(106,281);
        CGPoint rmin = CGPointMake(145,281);
        CGPoint dmin = CGPointMake(104, 318);
        CGPoint lmin = CGPointMake(70, 280);
        CGPoint umin = CGPointMake(108, 240);
        CGFloat yValueNeutral = 281;
        CGFloat xValueNeutral = 108;

    
        if (touches.count > 0) {
        
            if (xValue == 0 && yValue == 0){
                    NSLog(@"shit aint null: %@", touches);

                    [[self IOSView] endTouches:touches];
                    touches = nil;
        
            }
        
        }

        if (xValue != 0){
            NSLog(@"x value: %f", xValue);
            if (xValue > 0) { //moving right
                
                
                CGFloat newX = 185 * xValue;
                NSLog(@"new x: %f", newX);
                if (yValue != 0){
                    yValueNeutral *= ABS(yValue);
                }
                touches = [[self IOSView] dragFromPoint:CGPointMake(xValue, yValueNeutral) toPoint:lmin];
            } else if (0 > xValue){
                if (yValue != 0){
                    yValueNeutral *= ABS(yValue);
                }
                CGFloat newX = 185 * ABS(xValue);
                NSLog(@"lower new x: %f", newX);
                touches = [[self IOSView] dragFromPoint:lmin toPoint:CGPointMake(xValue, yValueNeutral)];
            } else {
              touches =   [[self IOSView] dragFromPoint:mid toPoint:mid];
            }
        } else {
            if (yValue != 0){
            NSLog(@"y value: %f", yValue);
            if (yValue > 0) { //moving up
                
                CGFloat newY = 241 * yValue;
                NSLog(@"new y: %f", newY);
                if (xValue != 0){
                    xValueNeutral *= ABS(xValue);
                }
                [[self IOSView] dragFromPoint:umin toPoint:CGPointMake(xValueNeutral, newY)];
            } else if (0 > yValue){
                CGFloat newY = 241 * ABS(yValue);
                NSLog(@"lower new y: %f", newY);
              touches = [[self IOSView] dragFromPoint:CGPointMake(xValueNeutral, newY) toPoint:dmin];
            } else {
               touches = [[self IOSView] dragFromPoint:mid toPoint:mid];
            }
        }
        }
        /*
        
        */
        
    };
    
    profile.leftThumbstickButton.valueChangedHandler = ^(GCControllerButtonInput * _Nonnull button, float value, BOOL pressed) {
        
        if (pressed){
            
            CGPoint hand = PAT(kPGBActionHandAction);
            [[self IOSView] tapAtPoint:hand];
        }
        
    };
    
    profile.rightThumbstickButton.valueChangedHandler = ^(GCControllerButtonInput * _Nonnull button, float value, BOOL pressed) {
        
        if (pressed){
            
            CGPoint first = PAT(kPGBActionFirstItemSelect);
            [[self IOSView] tapAtPoint:first];
        }
        
    };
    
    
    profile.dpad.valueChangedHandler = ^(GCControllerDirectionPad * _Nonnull dpad, float xValue, float yValue) {
        
        if (dpad.down.isPressed){
            CGPoint reload = PAT(kPGBActionTypeReload);
            [[self IOSView] tapAtPoint:reload];
            
        }
        
        if (dpad.left.isPressed){
            CGPoint leftWeapon = PAT(kPGBActionTypeFirstWeapon);
            [[self IOSView] tapAtPoint:leftWeapon];
        }
        
        if (dpad.up.isPressed){
            CGPoint aim = PAT(kPGBActionTypeAim);
            [[self IOSView] tapAtPoint:aim];
        }
        
        if (dpad.right.isPressed){
            CGPoint rightWeapon = PAT(kPGBActionTypeSecondWeapon);
            [[self IOSView] tapAtPoint:rightWeapon];
        }
        
        
    };
    
    profile.leftShoulder.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed){
            CGPoint training = PAT(kPGBActionTypeTrainingButton);
            [[self IOSView] tapAtPoint:training];
            
            CGPoint cancelPoint = PAT(kPGBActionTypeOKCancelButton);
            [[self IOSView] tapAtPoint:cancelPoint];
            
            CGPoint closePoint = [self convertPointForScreen:CGPointMake(610,72)];
            [[self IOSView] tapAtPoint:closePoint];
            
        }
    };
    
    profile.rightShoulder.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed){
            CGPoint start = PAT(kPGBActionTypeStartButton);
            [[self IOSView] tapAtPoint:start];
            
            CGPoint okPoint = PAT(kPGBActionTypeOKDualButton);
            [[self IOSView] tapAtPoint:okPoint];
            
            CGPoint okSolo = PAT(kPGBActionTypeOKSoloButton);
            [[self IOSView] tapAtPoint:okSolo];

            CGPoint closePoint = PAT(kPGBActionTypeXCloseButton);
            [[self IOSView] tapAtPoint:closePoint];
            
            //CGPoint cancelPoint2 = [self convertPointForScreen:CGPointMake(610,72)];
            //[[self IOSView] tapAtPoint:cancelPoint2];
            
        }
    };

    __block UITouch *currentRightTouch = nil;
    profile.rightTrigger.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed){
            CGPoint punchRight = PAT(kPGBActionTypeRight);
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
            CGPoint punchLeft = PAT(kPGBActionTypeLeft);
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
            CGPoint jump = PAT(kPGBActionTypeJump);
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
            CGPoint laydown = PAT(kPGBActionTypeConceal);
            [[self IOSView] tapAtPoint:laydown];
        }
    };
    
    profile.buttonX.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed)
        {
            CGPoint run = PAT(kPGBActionTypeRun);
            [[self IOSView] tapAtPoint:run];
        }
    };
    
    profile.buttonY.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed)
        {
            CGPoint crouch = PAT(kPGBActionTypeCrouch);
            [[self IOSView] tapAtPoint:crouch];
            
        }
    };
}

%new - (void)controllerDisconnected:(NSNotification *)n {
    %log;

}

- (_Bool)application:(id)arg1 didFinishLaunchingWithOptions:(id)arg2 {

    %log;
     NSArray *controllers = [GCController controllers];
     /*
    Class sb = NSClassFromString(@"BKSystemApplication");
    
    Class rth = NSClassFromString(@"SimulateTouchHelper");
    SimulateTouchHelper *sth = [SimulateTouchHelper sharedInstance];
    //[rmh setPbDelegateRef:self];
    NSLog(@"sth: %@", sth);

    Method touchCommand = class_getInstanceMethod(rth, @selector(handleTouchNotification:));

    class_addMethod(sb, @selector(handleTouchNotification:), method_getImplementation(touchCommand), method_getTypeEncoding(touchCommand));
    */
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controllerConnected:) name:GCControllerDidConnectNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(controllerDisconnected:) name:GCControllerDidDisconnectNotification object:nil];
    return %orig;

}

%end

%hook UIView
- (void)touchesCancelled:(id)arg1 withEvent:(id)arg2 { %log; %orig; }
- (void)touchesEnded:(id)arg1 withEvent:(id)arg2 { %log; %orig; } 
- (void)touchesMoved:(id)arg1 withEvent:(id)arg2 { %log; %orig; } 
- (void)touchesBegan:(id)arg1 withEvent:(id)arg2 { 	%log; %orig; }
- (void)HandleTouches:(id)arg1 ofType:(int)arg2 { %log; %orig; }

%end
