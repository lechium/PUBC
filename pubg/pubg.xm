#import "PUBGDefines.h"
#import "PUBGControllerManager.h"
//#import "FingerTips/MBFingerTipWindow.h"

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