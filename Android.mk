LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

SVERSION:=$(subst ., ,$(PLATFORM_VERSION))
SHORT_PLATFORM_VERSION=$(word 1,$(SVERSION))$(word 2,$(SVERSION))
LOCAL_CFLAGS += -DSHORT_PLATFORM_VERSION=$(SHORT_PLATFORM_VERSION)

ifeq ($(SHORT_PLATFORM_VERSION),43)
KLAATU_COMMON=init.klaatu-common-43.rc
else ifeq ($(SHORT_PLATFORM_VERSION),44)
KLAATU_COMMON=init.klaatu-common-43.rc
else
KLAATU_COMMON=init.klaatu-common.rc
endif

file := $(TARGET_ROOT_OUT)/init.klaatu-common.rc
$(file) : $(LOCAL_PATH)/init/$(KLAATU_COMMON) | $(ACP)
	$(transform-prebuilt-to-target)
ALL_MODULES += $(file)
ALL_DEFAULT_INSTALLED_MODULES += $(file)

file := $(TARGET_ROOT_OUT)/init.klaatu.rc
$(file) : $(LOCAL_PATH)/init/init.klaatu.rc | $(ACP)
	$(transform-prebuilt-to-target)
ALL_MODULES += $(file)
ALL_DEFAULT_INSTALLED_MODULES += $(file)

file := $(TARGET_ROOT_OUT)/init.klaatu-headless.rc
$(file) : $(LOCAL_PATH)/init/init.klaatu-headless.rc | $(TARGET_ROOT_OUT)/init.klaatu.rc $(ACP)
	$(transform-prebuilt-to-target)
	echo "import /init.klaatu-headless.rc" >> $(TARGET_ROOT_OUT)/init.klaatu.rc
	echo "headless Headless" >> $(TARGET_ROOT_OUT)/UIs.txt
ALL_MODULES += $(file)
ALL_DEFAULT_INSTALLED_MODULES += $(file)

file := $(TARGET_ROOT_OUT)/init.rc.preKlaatu
$(file) : $(LOCAL_PATH)/init/fixInitRc | $(TARGET_ROOT_OUT)/init.rc
	$(hide) sed -f $< -i.preKlaatu $(TARGET_ROOT_OUT)/init.rc
ALL_MODULES += $(file)
ALL_DEFAULT_INSTALLED_MODULES += $(file)

file := $(TARGET_OUT_EXECUTABLES)/hostname_init.sh
$(file) : $(LOCAL_PATH)/scripts/hostname_init.sh | $(ACP)
	$(transform-prebuilt-to-target)
ALL_MODULES += $(file)
ALL_DEFAULT_INSTALLED_MODULES += $(file)

ifdef KLAATU_DEFAULT_UI
file := $(TARGET_OUT_DATA)/property/persist.sys.ui.config
.PHONY: $(file)
$(file) :
	mkdir -p $(TARGET_OUT_DATA)/property
	echo -n $(KLAATU_DEFAULT_UI) > $(TARGET_OUT_DATA)/property/persist.sys.ui.config
ALL_MODULES += $(file)
ALL_DEFAULT_INSTALLED_MODULES += $(file)
endif
