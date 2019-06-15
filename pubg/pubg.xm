#import <GameController/GameController.h>
#import "NSObject+AssociatedObjects.h"
#import "UIView-KIFAdditions.h"
//static GCController* gameController = nil; //Dictionary{index:STTouch}

@interface IOSAppDelegate : UIResponder <UIApplicationDelegate, UITextFieldDelegate>

@property(retain) UIView *IOSView; // @synthesize IOSView;
- (CGPoint)convertPointForScreen:(CGPoint)inputPoint;

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

#define degreesToRadians(x) (M_PI * (x) / 180.0)

%hook IOSAppDelegate

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

%new - (void)controllerConnected:(NSNotification *)n {

    %log;
   // NSLog(@"n: %@", n);
 //   self.gameController = n.object;
    GCController *gameController = n.object;
    //28/140 = training button
    GCExtendedGamepad *profile = gameController.extendedGamepad;

    profile.leftThumbstick.valueChangedHandler = ^(GCControllerDirectionPad * _Nonnull dpad, float xValue, float yValue) {
           
        
        CGPoint mid = CGPointMake(106,281);
        CGPoint rmin = CGPointMake(145,281);
        CGPoint dmin = CGPointMake(104, 318);
        CGPoint lmin = CGPointMake(70, 280);
        CGPoint umin = CGPointMake(108, 200);
        CGFloat yValueNeutral = 281;
        CGFloat xValueNeutral = 108;
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
            }
        }
      
    };
    
    profile.dpad.valueChangedHandler = ^(GCControllerDirectionPad * _Nonnull dpad, float xValue, float yValue) {
      
        if (dpad.down.isPressed){
            NSLog(@"dpad down");
        }
        
        if (dpad.left.isPressed){
            NSLog(@"dpad left");
        }
        
        if (dpad.up.isPressed){
            NSLog(@"dpad up");
        }
        
        if (dpad.right.isPressed){
            NSLog(@"dpad right");
        }
        
        
    };

    profile.leftShoulder.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed){
            NSLog(@"right should pressed hit training mode");
            CGPoint training = CGPointMake(28, 140);
            CGPoint converted = [self convertPointForScreen:training];
            [[self IOSView] tapAtPoint:converted];

            CGPoint cancelPoint = [self convertPointForScreen:CGPointMake(281,266)];
            [[self IOSView] tapAtPoint:cancelPoint];

        }
    };

     profile.rightShoulder.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed){
            NSLog(@"right should pressed hit start mode");
            CGPoint start = CGPointMake(81, 32);
            CGPoint converted = [self convertPointForScreen:start];
            [[self IOSView] tapAtPoint:converted];

            CGPoint okPoint = [self convertPointForScreen:CGPointMake(388,266)];
            [[self IOSView] tapAtPoint:okPoint];

            CGPoint cancelPoint = [self convertPointForScreen:CGPointMake(627,31)];
            [[self IOSView] tapAtPoint:cancelPoint];

            CGPoint cancelPoint2 = [self convertPointForScreen:CGPointMake(610,72)];
            [[self IOSView] tapAtPoint:cancelPoint2];

        }
    };
    profile.rightTrigger.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed){
            NSLog(@"right trigger pressed punch right");
            CGPoint punchRight = CGPointMake(565, 275);
            CGPoint converted = [self convertPointForScreen:punchRight];
            [[self IOSView] tapAtPoint:converted];
            //[[self IOSView] tapAtPoint:punchRight];
        }
    };
    profile.leftTrigger.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed)
        {
            NSLog(@"left trigger punch left");
            CGPoint punchLeft = CGPointMake(39, 198);
            CGPoint converted = [self convertPointForScreen:punchLeft];
            [[self IOSView] tapAtPoint:converted];
            //[[self IOSView] tapAtPoint:punchLeft];
        }
    };
    
    profile.buttonA.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed)
        {
            NSLog(@"buttonA pressed, jump");
            CGPoint jump = CGPointMake(639, 258);
            CGPoint converted = [self convertPointForScreen:jump];
            [[self IOSView] longPressAtPoint:converted duration: .1];
            //[[self IOSView] longPressAtPoint: jump duration: .1];
        }
    };
    
    profile.buttonB.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed)
        {
            CGPoint laydown = CGPointMake(617, 345);
            CGPoint converted = [self convertPointForScreen:laydown];
            [[self IOSView] tapAtPoint:converted];
            //[[self IOSView] tapAtPoint:laydown];
            NSLog(@"buttonB pressed lay down");
        }
    };
    
    profile.buttonX.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed)
        {
            CGPoint run = CGPointMake(558, 99);
            CGPoint converted = [self convertPointForScreen:run];
            [[self IOSView] tapAtPoint:converted];
            //[[self IOSView] tapAtPoint:run];
            NSLog(@"buttonX pressed run");
        }
    };
    
    profile.buttonY.valueChangedHandler = ^(GCControllerButtonInput *button, float value, BOOL pressed)
    {
        if (pressed)
        {
            CGPoint crouch = CGPointMake(560, 349);
            CGPoint converted = [self convertPointForScreen:crouch];
            [[self IOSView] tapAtPoint:converted];
            //[[self IOSView] tapAtPoint:crouch];

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
