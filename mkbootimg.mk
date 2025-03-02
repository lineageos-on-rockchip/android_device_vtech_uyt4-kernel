LOCAL_PATH := $(call my-dir)

INSTALLED_RESOURCE_TARGET := $(BOARD_PREBUILT_RESOURCEIMAGE)

## Overload bootimg generation: Same as the original, + --second arg
$(INSTALLED_BOOTIMAGE_TARGET): $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_FILES) $(INSTALLED_RESOURCE_TARGET)
	$(call pretty,"Target boot image: $@  ${MKBOOTIMG} ${INTERNAL_BOOTIMAGE_ARGS} ${BOARD_MKBOOTIMG_ARGS}")
	@echo -e ${CL_CYN}"----- Making boot image ------"${CL_RST}
	$(hide) $(MKBOOTIMG) $(INTERNAL_BOOTIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --second $(INSTALLED_RESOURCE_TARGET) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_BOOTIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_CYN}"Made boot image: $@"${CL_RST}

## Overload recoveryimg generation: Same as the original, + --second arg
$(INSTALLED_RECOVERYIMAGE_TARGET): $(MKBOOTIMG) $(INSTALLED_RESOURCE_TARGET) \
		$(recovery_ramdisk) \
		$(recovery_kernel)
	@echo -e ${CL_CYN}"----- Making recovery image ------"${CL_RST}
	$(hide) $(MKBOOTIMG) $(INTERNAL_RECOVERYIMAGE_ARGS) $(BOARD_MKBOOTIMG_ARGS) --second $(INSTALLED_RESOURCE_TARGET) --output $@
	$(hide) $(call assert-max-image-size,$@,$(BOARD_RECOVERYIMAGE_PARTITION_SIZE),raw)
	@echo -e ${CL_CYN}"Made recovery image: $@"${CL_RST}
