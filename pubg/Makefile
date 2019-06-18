ARCHS = arm64
TARGET = iphone
export GO_EASY_ON_ME=1
export SDKVERSION=10.2
THEOS_DEVICE_IP=eleven.local

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = PUBC 
PUBC_FILES = pubg.xm NSObject+AssociatedObjects.m KIF/NSPredicate+KIFAdditions.m KIF/NSException-KIFAdditions.m KIF/UIEvent+KIFAdditions.m KIF/UIView-KIFAdditions.m KIF/CGGeometry-KIFAdditions.m KIF/NSString+KIFAdditions.m KIF/UIScreen+KIFAdditions.m KIF/UIWindow-KIFAdditions.m KIF/IOHIDEvent+KIF.m KIF/UITouch-KIFAdditions.m KIF/NSError-KIFAdditions.m KIF/UIApplication-KIFAdditions.m KIF/UIView-Debugging.m
PUBC_LIBRARIES = substrate
PUBC_FRAMEWORKS = Foundation IOKit GameController
PUBC_CFLAGS += -I. -IKIF
PUBC_LDFLAGS = -undefined dynamic_lookup
#PUBC_CODESIGN_FLAGS=-Slibrespring.xml

include $(THEOS_MAKE_PATH)/tweak.mk

after-install::
	install.exec "killall -9 ShadowTrackerExtra"
