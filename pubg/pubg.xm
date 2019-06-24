#import "PUBGDefines.h"
#import "PUBGControllerManager.h"
#import <GameController/GameController.h>
#import "NSObject+AssociatedObjects.h"
//#import "FingerTips/MBFingerTipWindow.h"


%hook GCController

+ (NSArray<GCController *> *)controllers {

    NSDictionary *gpd = [[PUBGControllerManager sharedManager] controllerPreferences];
    BOOL enabled = [gpd[ExperimentalControl] boolValue];
    if (enabled) {
        //NSLog(@"no controllers for you!");
        return nil;
    }
    return %orig;
}

%end


%hook IOSAppDelegate


- (_Bool)application:(id)arg1 didFinishLaunchingWithOptions:(id)arg2 {

    %log;
    NSLog(@"PUBC: #### in application:didFinishLaunchingWithOptions");
    PUBGControllerManager *man = [PUBGControllerManager sharedManager];
    [man listenForControllers];
 

    return %orig;

}

%end