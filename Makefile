include $(THEOS)/makefiles/common.mk

export TARGET = iphone:clang:13.0:11.0
export ARCHS = arm64 arm64e

BUNDLE_NAME = NightShiftModule
NightShiftModule_BUNDLE_EXTENSION = bundle
NightShiftModule_FILES = $(wildcard *.m)
NightShiftModule_FRAMEWORKS = Preferences
NightShiftModule_PRIVATE_FRAMEWORKS = ControlCenterUIKit AccessibilityUtilities
NightShiftModule_CFLAGS = -fobjc-arc -O3 
NightShiftModule_INSTALL_PATH = /Library/ControlCenter/Bundles/

after-install::
	install.exec "killall -9 SpringBoard"

include $(THEOS_MAKE_PATH)/bundle.mk
