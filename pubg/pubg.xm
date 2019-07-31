#import "PUBGDefines.h"
#import "PUBGControllerManager.h"
#import <GameController/GameController.h>
#import "NSObject+AssociatedObjects.h"
#import "pubghooks/pubghooks.h"
#include "pubghooks/pubghooks.h"

%hook _GCControllerAxisInput

-(float)value {
    
    //%log;
    float orig = %orig;
    if (orig > 0 || orig < 0){
        float ps = [CM panningSpeed];
        float aps = [CM aimPanningSpeed];
        if (ps == 0) { ps = 3.0; }
        if (ph_is_hooker()) {
            int mt = ph_get_is_aimed_down_sights();
            if (mt == 1){
                if (aps < 1.0 && aps > 2.0){
                    ps = 1.0;
                } else {
                    //NSLog(@"PUBC: custom aim panning speed: %f", aps);
                    ps = aps;
                }
            }
        }
        
        BOOL inverted = [CM invertedControl];
        if (!inverted){
            GCControllerDirectionPad *rt = [[[CM gameController] extendedGamepad] rightThumbstick];
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
 
 they update this after us, so they end up taking over and doing nothing with it
 here we just force it to do our bidding instead. it may be smarter just to have
 it call the hide/show for the control editor, but this works.
 
 */

%hook _GCController

- (id)controllerPausedHandler {
  
    id cph = [CM controllerPausedHandler];
    if (cph){
        return cph;
    }
    id orig = %orig;
    return orig;
}

%end


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
    [CM appWasActivated];
}

- (_Bool)application:(id)arg1 didFinishLaunchingWithOptions:(id)arg2 {

    %log;
    NSLog(@"PUBC: #### in application:didFinishLaunchingWithOptions");
    [CM listenForControllers];
    return %orig;

}

%end
