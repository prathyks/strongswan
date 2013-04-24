LOCAL_PATH := $(call my-dir)
include $(CLEAR_VARS)

# copy-n-paste from Makefile.am
LOCAL_SRC_FILES := \
android_jni.c \
backend/android_attr.c \
backend/android_creds.c \
backend/android_private_key.c \
backend/android_service.c \
charonservice.c \
kernel/android_ipsec.c \
kernel/android_net.c \
kernel/network_manager.c \
vpnservice_builder.c

ifneq ($(strongswan_USE_BYOD),)
LOCAL_SRC_FILES += \
byod/imc_android_state.c \
byod/imc_android.c
endif

# build libandroidbridge -------------------------------------------------------

LOCAL_C_INCLUDES += \
	$(libvstr_PATH) \
	$(strongswan_PATH)/src/libipsec \
	$(strongswan_PATH)/src/libhydra \
	$(strongswan_PATH)/src/libcharon \
	$(strongswan_PATH)/src/libstrongswan

ifneq ($(strongswan_USE_BYOD),)
LOCAL_C_INCLUDES += \
	$(strongswan_PATH)/src/libimcv \
	$(strongswan_PATH)/src/libtncif \
	$(strongswan_PATH)/src/libtnccs \
	$(strongswan_PATH)/src/libpts \
	$(strongswan_PATH)/src/libtls
endif

LOCAL_CFLAGS := $(strongswan_CFLAGS) \
	-DPLUGINS='"$(strongswan_CHARON_PLUGINS)"'

LOCAL_MODULE := libandroidbridge

LOCAL_MODULE_TAGS := optional

LOCAL_ARM_MODE := arm

LOCAL_PRELINK_MODULE := false

LOCAL_LDLIBS := -llog

LOCAL_SHARED_LIBRARIES := libstrongswan libhydra libipsec libcharon

ifneq ($(strongswan_USE_BYOD),)
LOCAL_SHARED_LIBRARIES += libimcv libtncif libtnccs libpts
endif

include $(BUILD_SHARED_LIBRARY)


