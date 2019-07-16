ARCHS = arm64e armv7 armv7s arm64
TARGET = iphone
export GO_EASY_ON_ME=1
export SDKVERSION=12.1
THEOS_DEVICE_IP=192.168.0.2
DEBUG=0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PUBC 
PUBC_FILES = pubg.xm Categories/NSObject+AssociatedObjects.m KIF/UIEvent+KIFAdditions.m KIF/UIView-KIFAdditions.m KIF/CGGeometry-KIFAdditions.m KIF/UIScreen+KIFAdditions.m KIF/UIWindow-KIFAdditions.m KIF/IOHIDEvent+KIF.m KIF/UITouch-KIFAdditions.m KIF/NSError-KIFAdditions.m KIF/UIApplication-KIFAdditions.m KIF/UIView-Debugging.m PUBGControllerManager.m #FingerTips/MBFingerTipWindow.m
PUBC_FILES += PureLayout/ALView+PureLayout.m PureLayout/NSArray+PureLayout.m PureLayout/NSLayoutConstraint+PureLayout.m
PUBC_FILES += Preferences/PUBPrefTableViewController.m Preferences/PUBControlListTableViewController.m Categories/UIWindow+Additions.m
PUBC_FILES += RKDropdownAlert/RKDropdownAlert.m
PUBC_FILES += extobjc/EXTRuntimeExtensions.m extobjc/EXTScope.m 
PUBC_LIBRARIES = substrate
PUBC_FRAMEWORKS = Foundation IOKit GameController
PUBC_CFLAGS += -I.-IRKDropdownAlert -Iextobjc -IPureLayout -IKIF -IPreferences -ICategories -fobjc-arc -miphoneos-version-min=9.0
PUBC_LDFLAGS = -miphoneos-version-min=9.0 -undefined dynamic_lookup
#PUBC_CODESIGN_FLAGS=-Slibrespring.xml

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 ShadowTrackerExtra ; lsdtrip launch com.tencent.ig"
