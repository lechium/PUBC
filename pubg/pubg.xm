#import <GameController/GameController.h>
#import "NSObject+AssociatedObjects.h"
#import "UIView-KIFAdditions.h"
//static GCController* gameController = nil; //Dictionary{index:STTouch}

typedef enum {
    
    PGBActionTypeLeft,
    PGBActionTypeRight,
    PGBActionTypeRun,
    PGBActionTypeCrouch,
    PGBActionTypeConceal,
    PGBActionTypeJump,
    PGBActionTypeFirstWeapon,
    PGBActionTypeSecondWeapon,
    PGBActionTypeSmallWeapon,
    PGBActionTypeAim,
    PGBActionTypeReload,
    PGBActionTypeExitRound,
    PGBActionTypeOKCancelButton,
    PGBActionTypeXCloseButton,
    PGBActionTypeXClose2Button,
    PGBActionTypeOKDualButton,
    PGBActionTypeOKSoloButton,
    PGBActionTypeInventory,
    PGBActionHandAction,
    PGBActionFirstItemSelect,
    PGBActionMapAction,
    PGBActionTypeTrainingButton,
    PGBActionTypeStartButton,
    
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

%new - (CGPoint)pointForActionType:(PGBActionType)type {
    
    CGPoint outpoint = CGPointZero;
    
    switch (type) {
        case PGBActionTypeAim:
            
            outpoint = [self convertPointForScreen:CGPointMake(641,197)];
            break;
            
        case PGBActionTypeRun:
            
            outpoint = [self convertPointForScreen:CGPointMake(558, 99)];
            break;
            
        case PGBActionTypeConceal: //lay down
            
            outpoint = [self convertPointForScreen:CGPointMake(617, 345)];
            break;
    
        case PGBActionTypeReload:
            outpoint = [self convertPointForScreen:CGPointMake(508,353)];
            break;
            
        case PGBActionTypeFirstWeapon:
            outpoint = [self convertPointForScreen:CGPointMake(290,340)];
            break;
  
        case PGBActionTypeSecondWeapon:
            outpoint = [self convertPointForScreen:CGPointMake(376,340)];
            break;
            
        case PGBActionTypeTrainingButton:
            outpoint = [self convertPointForScreen:CGPointMake(28, 140)];
            break;
            
        case PGBActionTypeOKCancelButton:    //Cancel button (on ok/cancel alert)
            outpoint = [self convertPointForScreen:CGPointMake(281,266)];
            break;
            
        case PGBActionTypeXCloseButton:  //top right close x
            outpoint = [self convertPointForScreen:CGPointMake(610,72)];
            break;
   
        case PGBActionTypeStartButton:
            outpoint = [self convertPointForScreen:CGPointMake(81, 32)];
            break;
            
        case PGBActionTypeOKDualButton: //(point for OK on Cancel / OK alert)
            outpoint = [self convertPointForScreen:CGPointMake(388,266)];
            break;
            
        case PGBActionTypeXClose2Button: //lower close X
            outpoint = [self convertPointForScreen:CGPointMake(627,31)];
            break;
    
        case PGBActionTypeRight:
            outpoint = [self convertPointForScreen:CGPointMake(565, 275)];
            break;
            
        case PGBActionTypeLeft:
            outpoint = [self convertPointForScreen:CGPointMake(39, 198)];
            break;
            
        case PGBActionTypeJump:
            outpoint = [self convertPointForScreen:CGPointMake(639, 258)]; //long press
            break;
            
        case PGBActionTypeCrouch:
            outpoint = [self convertPointForScreen:CGPointMake(560, 349)];
            break;
        case PGBActionTypeSmallWeapon:
            outpoint = [self convertPointForScreen:CGPointMake(406,313)];
            break;
            
        case PGBActionTypeExitRound:
            outpoint = [self convertPointForScreen:CGPointMake(64,13)];
            break;
            
        case PGBActionTypeInventory:
            outpoint =  [self convertPointForScreen:CGPointMake(48, 343)];
            break;
            
        case PGBActionHandAction:
            outpoint = [self convertPointForScreen:CGPointMake(480,95)];
            break;
            
        case PGBActionFirstItemSelect:
            outpoint = [self convertPointForScreen:CGPointMake(437,132)];// y+50 = 2 item y+ 100 = 3rd item
            break;

        case PGBActionTypeOKSoloButton:
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
    profile.leftThumbstick.valueChangedHandler = ^(GCControllerDirectionPad * _Nonnull dpad, float xValue, float yValue) {
        
        
        CGPoint mid = CGPointMake(106,281);
        CGPoint rmin = CGPointMake(145,281);
        CGPoint dmin = CGPointMake(104, 318);
        CGPoint lmin = CGPointMake(70, 280);
        CGPoint umin = CGPointMake(108, 200);
        CGFloat yValueNeutral = 281;
        CGFloat xValueNeutral = 108;

        if (xValue == 0 && yValue == 0){

            if (touches){

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
                    //yValueNeutral * ABS(yValue);
                }
                 [[self IOSView] dragFromPoint:CGPointMake(xValue, yValueNeutral) toPoint:lmin steps:2];
            } else if (0 > xValue){
                CGFloat newX = 185 * ABS(xValue);
                NSLog(@"lower new x: %f", newX);
                 [[self IOSView] dragFromPoint:lmin toPoint:CGPointMake(xValue, yValueNeutral) steps:2];
            } else {
                [[self IOSView] dragFromPoint:mid toPoint:mid steps:2];
            }
        }
        if (yValue != 0){
            NSLog(@"y value: %f", yValue);
            if (yValue > 0) { //moving up
                
                CGFloat newY = 241 * yValue;
                NSLog(@"new y: %f", newY);
                if (xValue != 0){
                    //xValueNeutral * ABS(xValue);
                }
                [[self IOSView] dragFromPoint:umin toPoint:CGPointMake(xValueNeutral, newY) steps:2];
            } else if (0 > yValue){
                CGFloat newY = 241 * ABS(yValue);
                NSLog(@"lower new y: %f", newY);
                [[self IOSView] dragFromPoint:CGPointMake(xValueNeutral, newY) toPoint:dmin steps:2];
            } else {
                [[self IOSView] dragFromPoint:mid toPoint:mid steps:2];
            }
        }
        
    };
    
    profile.leftThumbstickButton.valueChangedHandler = ^(GCControllerButtonInput * _Nonnull button, float value, BOOL pressed) {
        
        if (pressed){
            
            CGPoint hand = PAT(PGBActionHandAction);
            [[self IOSView] tapAtPoint:hand];
        }
        
    };
    
    profile.rightThumbstickButton.valueChangedHandler = ^(GCControllerButtonInput * _Nonnull button, float value, BOOL pressed) {
        
        if (pressed){
            
            CGPoint first = PAT(PGBActionFirstItemSelect);
            [[self IOSView] tapAtPoint:first];
        }
        
    };
    
    
    profile.dpad.valueChangedHandler = ^(GCControllerDirectionPad * _Nonnull dpad, float xValue, float yValue) {
        
        if (dpad.down.isPressed){
            NSLog(@"dpad down");
            CGPoint reload = PAT(PGBActionTypeReload);
            [[self IOSView] tapAtPoint:reload];
            
        }
        
        if (dpad.left.isPressed){
            NSLog(@"dpad left");
            CGPoint leftWeapon = PAT(PGBActionTypeFirstWeapon);
            [[self IOSView] tapAtPoint:leftWeapon];
        }
        
        if (dpad.up.isPressed){
            NSLog(@"dpad up");
            CGPoint aim = PAT(PGBActionTypeAim);
            [[self IOSView] tapAtPoint:aim];
        }
        
        if (dpad.right.isPressed){
            NSLog(@"dpad right");
            CGPoint rightWeapon = PAT(PGBActionTypeSecondWeapon);
            [[self IOSView] tapAtPoint:rightWeapon];
        }
        
        
    };
    
    profile.leftShoulder.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed){
            NSLog(@"right should pressed hit training mode");
            CGPoint training = PAT(PGBActionTypeTrainingButton);
            [[self IOSView] tapAtPoint:training];
            
            CGPoint cancelPoint = PAT(PGBActionTypeOKCancelButton);
            [[self IOSView] tapAtPoint:cancelPoint];
            
            CGPoint closePoint = [self convertPointForScreen:CGPointMake(610,72)];
            [[self IOSView] tapAtPoint:closePoint];
            
        }
    };
    
    profile.rightShoulder.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed){
            NSLog(@"right should pressed hit start mode");
            CGPoint start = PAT(PGBActionTypeStartButton);
            [[self IOSView] tapAtPoint:start];
            
            CGPoint okPoint = PAT(PGBActionTypeOKDualButton);
            [[self IOSView] tapAtPoint:okPoint];
            
            CGPoint okSolo = PAT(PGBActionTypeOKSoloButton);
            [[self IOSView] tapAtPoint:okSolo];

            CGPoint closePoint = PAT(PGBActionTypeXCloseButton);
            [[self IOSView] tapAtPoint:closePoint];
            
            //CGPoint cancelPoint2 = [self convertPointForScreen:CGPointMake(610,72)];
            //[[self IOSView] tapAtPoint:cancelPoint2];
            
        }
    };

    __block UITouch *currentRightTouch = nil;
    profile.rightTrigger.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed){
            NSLog(@"right trigger pressed punch right");
            CGPoint punchRight = PAT(PGBActionTypeRight);
            currentRightTouch = [[self IOSView] tapDownAtPoint:punchRight];
        } else {    

            if (currentRightTouch) {
                NSLog(@"touch up: %@", currentRightTouch);
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
            NSLog(@"left trigger punch left");
            CGPoint punchLeft = PAT(PGBActionTypeLeft);
            currentLeftTouch = [[self IOSView] tapDownAtPoint:punchLeft];
        } else {    

            if (currentLeftTouch) {
                NSLog(@"touch up: %@", currentLeftTouch);
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
            NSLog(@"buttonA pressed, jump");
            CGPoint jump = PAT(PGBActionTypeJump);
            //jumpTouch = [[self IOSView] longPressAtPoint: jump duration: .1];
            jumpTouch =  [[self IOSView] tapDownAtPoint:jump];
        } else {
            if (jumpTouch) {
                NSLog(@"touch up: %@", jumpTouch);
                [[self IOSView] finishTouch:jumpTouch];
                jumpTouch = nil;
            }

        }
    };

    
    profile.buttonB.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed)
        {
            CGPoint laydown = PAT(PGBActionTypeConceal);
            [[self IOSView] tapAtPoint:laydown];
            NSLog(@"buttonB pressed lay down");
        }
    };
    
    profile.buttonX.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed)
        {
            CGPoint run = PAT(PGBActionTypeRun);
            [[self IOSView] tapAtPoint:run];
            NSLog(@"buttonX pressed run");
        }
    };
    
    profile.buttonY.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed)
        {
            CGPoint crouch = PAT(PGBActionTypeCrouch);
            [[self IOSView] tapAtPoint:crouch];
            
            NSLog(@"buttonY pressed crouch");
        }
    };
}

%new - (void)controllerDisconnected:(NSNotification *)n {
    %log;

}

- (_Bool)application:(id)arg1 didFinishLaunchingWithOptions:(id)arg2 {

    %log;
     NSArray *controllers = [GCController controllers];
     NSLog(@"controllers: %@", controllers);
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
