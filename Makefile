ARCHS = arm64e arm64 armv7 armv7s

THEOS_DEVICE_IP = 192.168.1.40

DEBUG = 0

include $(THEOS)/makefiles/common.mk

TWEAK_NAME = OSLogger

OSLogger_FILES = Tweak.xm CMManager.m
OSLogger_CFLAGS = -fobjc-arc

include $(THEOS_MAKE_PATH)/tweak.mk


install::
		install.exec
