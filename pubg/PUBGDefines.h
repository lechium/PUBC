/**
 
 These constants exist to simplify key mapping in the project (and for autocompletion sanity)
 
 The top section are all the different buttons pubc simulates the touches for the bottom list
 is the constants for the buttons we support custom mapping for on said controller.
 
 for now edit layout/var/mobile/Library/Preferences/com.nito.pubc.plist.og if you want to customize
 your layout before building.
 
 */

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
static NSString * const PGBActionTypePeakLeft = @"PGBActionTypePeakLeft";
static NSString * const PGBActionTypePeakRight = @"PGBActionTypePeakRight";

static NSString * const PGBActionTypeDrive = @"PGBActionTypeDrive";
static NSString * const PGBActionTypeGetIn = @"PGBActionTypeGetIn";

static NSString * const PGBActionTypeDriveFW = @"PGBActionTypeDriveFW";
static NSString * const PGBActionTypeDriveBW = @"PGBActionTypeDriveBW";
static NSString * const PGBActionTypeDriveLeft = @"PGBActionTypeDriveLeft";
static NSString * const PGBActionTypeDriveRight = @"PGBActionTypeDriveRight";
static NSString * const PGBActionTypeDriveHorn = @"PGBActionTypeDriveHorn";
static NSString * const PGBActionTypeDriveExit = @"PGBActionTypeDriveExit";
static NSString * const PGBActionTypeDriveUp = @"PGBActionTypeDriveUp";
static NSString * const PGBActionTypeDriveDown = @"PGBActionTypeDriveDown";
static NSString * const PGBActionTypeDriveBrake = @"PGBActionTypeDriveBrake";
static NSString * const PGBActionTypeDriveSpeedBoost =@"PGBActionTypeDriveSpeedBoost";
static NSString * const PGBActionTypeDriveChangeSeat =@"PGBActionTypeDriveChangeSeat";

static NSString * const LeftThumbstick = @"LeftThumbstick";
static NSString * const RightThumbstick = @"RightThumbstick";
static NSString * const LeftThumbstickButton = @"LeftThumbstickButton";
static NSString * const RightThumbstickButton = @"RightThumbstickButton";
static NSString * const LeftShoulder = @"LeftShoulder";
static NSString * const RightShoulder = @"RightShoulder";
static NSString * const RightTrigger = @"RightTrigger";
static NSString * const LeftTrigger = @"LeftTrigger";
static NSString * const ButtonA = @"ButtonA";
static NSString * const ButtonB = @"ButtonB";
static NSString * const ButtonX = @"ButtonX";
static NSString * const ButtonY = @"ButtonY";
static NSString * const DpadUp = @"Dpad.up";
static NSString * const DpadDown = @"Dpad.down";
static NSString * const DpadLeft = @"Dpad.left";
static NSString * const DpadRight = @"Dpad.right";
static NSString * const Menu = @"Menu";

static NSString *const ExperimentalControl = @"ExperimentalControl";
static NSString *const InvertedControl = @"InvertedControl";
static NSString *const PanningSpeed = @"PanningSpeed";
static NSString *const AimPanningSpeed = @"AimPanningSpeed";

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
    kPGBActionTypePeakLeft,
    kPGBActionTypePeakRight,
    kPGBActionTypeDrive,
    kPGBActionTypeGetIn,
    kPGBActionTypeDriveFW,
    kPGBActionTypeDriveBW,
    kPGBActionTypeDriveLeft,
    kPGBActionTypeDriveRight,
    kPGBActionTypeDriveHorn,
    kPGBActionTypeDriveExit,
    kPGBActionTypeDriveUp,
    kPGBActionTypeDriveDown,
    kPGBActionTypeDriveBrake,
    kPGBActionTypeDriveSpeedBoost,
    kPGBActionTypeDriveChangeSeat,
    kPGBActionTypeUndefined,
    
} PGBActionType;

typedef enum {
    
    kPBGControlTypeDefault,
    kPBGControlTypeDriving,
    
} PGBControlType;

// System info
#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

#import <GameController/GameController.h>
#import "EXTScope.h"

@interface GCController (pubc)

@property (nonatomic) NSObject *gateKeeper;

@end
