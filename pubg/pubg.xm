#import "PUBGDefines.h"
#import "PUBGControllerManager.h"
#import <GameController/GameController.h>
#import "NSObject+AssociatedObjects.h"
//#import "FingerTips/MBFingerTipWindow.h"



@implementation GCController (pubc)

- (NSObject *)gateKeeper
{
    return [self associatedValueForKey:@selector(gateKeeper)];
}

- (void)setGateKeeper:(NSObject *)gateKeeper
{
    [self associateValue:gateKeeper withKey:@selector(gateKeeper)];
}

@end

%hook GCController

- (GCExtendedGamepad *)extendedGamepad {
    %log;
    if ([self gateKeeper] != nil) {
        return nil;
    } 
    return %orig;
}

+ (NSArray<GCController *> *)controllers {

    %log;
    return %orig;
}

%end


%hook IOSAppDelegate


- (_Bool)application:(id)arg1 didFinishLaunchingWithOptions:(id)arg2 {

    %log;
    PUBGControllerManager *man = [PUBGControllerManager sharedManager];
    [man listenForControllers];
    //UIWindow *keyWindow = UIApplication.sharedApplication.keyWindow;
    //[keyWindow MBFingerTipWindow_commonInit];

    return %orig;

}

%end