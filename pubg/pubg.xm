#import "PUBGDefines.h"
#import "PUBGControllerManager.h"
#import <GameController/GameController.h>
#import "NSObject+AssociatedObjects.h"
#import "pubghooks/pubghooks.h"
//#import "FingerTips/MBFingerTipWindow.h"

#include "pubghooks/pubghooks.h"

%hook FMetalDebugRenderCommandEncoder

- (void)setTessellationFactorBuffer:(id)arg1 offset:(unsigned long long)arg2 instanceStride:(unsigned long long)arg3 {

    %log;
    %orig;

}

%end

%hook _GCControllerAxisInput

-(float)value {
    
    //%log;
    float orig = %orig;
    if (orig > 0 || orig < 0){
        PUBGControllerManager *man = [PUBGControllerManager sharedManager];
        float ps = [man panningSpeed];
        if (ps == 0) { ps = 3.0; }
        if (ph_is_hooker()) {
            int mt = ph_get_is_aimed_down_sights();
            if (mt == 1){
                ps = 1.0;
            }
        }
        
        BOOL inverted = [man invertedControl];
        if (!inverted){
            GCControllerDirectionPad *rt = [[[man gameController] extendedGamepad] rightThumbstick];
            GCControllerAxisInput *rightY = rt.yAxis;
            if ((_GCControllerAxisInput*)rightY == self){
                return orig*-ps;
            }
        }
        return orig*ps;
    }
    return orig;
}

%end
/*
%hook GCController

+ (NSArray<GCController *> *)controllers {

    PUBGControllerManager *man = [PUBGControllerManager sharedManager];
    NSDictionary *gpd = [man controllerPreferences];
    BOOL enabled = [gpd[ExperimentalControl] boolValue];
   // NSArray *callStack = [NSThread callStackSymbols];
   // NSLog(@"callstack: %@", callStack);
    if (enabled) {
        //NSLog(@"no controllers for you!");
        man.gameControllers = %orig;
        return nil;
    }
    return %orig;
}

%end
*/

static int has_launched = 0;

%hook IOSAppDelegate

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /* don't know if it's bad to call MSHookFunction twice on the same
     * function... shouldn't be. But just to make sure.
     */
    if(!has_launched){
        ph_initialize();
        has_launched = 1;
    }

    %orig;
    [[PUBGControllerManager sharedManager] appWasActivated];
}



- (_Bool)application:(id)arg1 didFinishLaunchingWithOptions:(id)arg2 {

    %log;
    NSLog(@"PUBC: #### in application:didFinishLaunchingWithOptions");
    PUBGControllerManager *man = [PUBGControllerManager sharedManager];
    [man listenForControllers];
 

    return %orig;

}

%end
