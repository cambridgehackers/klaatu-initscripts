LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

LOCAL_SRC_FILES:= \
	qtklaatu-qmlscene-dependencyForcer.c

#LOCAL_SHARED_LIBRARIES := \
#	libutils \
#	libbinder


ifeq ($(TARGET_OS),linux)
	LOCAL_CFLAGS += -DXP_UNIX
#LOCAL_SHARED_LIBRARIES += librt
endif

LOCAL_MODULE:= qtklaatu-qmlscene-dependencyForcer
LOCAL_MODULE_TAGS := eng
LOCAL_MODULE_CLASS := EXECUTABLES

intermediates:= $(local-intermediates-dir)

GEN := $(LOCAL_PATH)/qtklaatu-qmlscene-dependencyForcer.c
$(GEN): PRIVATE_INPUT_FILE := $(LOCAL_PATH)/AndroidQtBuild.sh
$(GEN): PRIVATE_CUSTOM_TOOL = bash $(PRIVATE_INPUT_FILE) $@ $(LOCAL_PATH)
$(GEN): $(LOCAL_PATH)/AndroidQtBuild.sh 
	$(transform-generated-source)
#LOCAL_GENERATED_SOURCES += $(GEN)



include $(BUILD_EXECUTABLE)
