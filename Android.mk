LOCAL_PATH:= $(call my-dir)
include $(CLEAR_VARS)

file := $(TARGET_ROOT_OUT)/init.klaatu-common.rc
$(file) : $(LOCAL_PATH)/init/init.klaatu-common.rc | $(ACP)
	$(transform-prebuilt-to-target)
ALL_MODULES += $(file)
ALL_DEFAULT_INSTALLED_MODULES += $(file)

file := $(TARGET_ROOT_OUT)/init.klaatu.rc
$(file) : $(LOCAL_PATH)/init/init.klaatu.rc | $(ACP)
	$(transform-prebuilt-to-target)
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
KLAATU_COMPONENTS_RC = $(shell echo $(KLAATU_COMPONENTS) | tr [:upper:] [:lower:] | sed "s:klaatu_include_\([a-z0-9_-]*\):$(TARGET_ROOT_OUT)/init.klaatu-\1.rc:g")
file := $(TARGET_OUT_DATA)/property/persist.sys.ui.config
$(file) : $(KLAATU_COMPONENTS_RC)
	echo -n $(KLAATU_DEFAULT_UI) > $(TARGET_OUT_DATA)/property/persist.sys.ui.config
ALL_MODULES += $(file)
ALL_DEFAULT_INSTALLED_MODULES += $(file)
endif
