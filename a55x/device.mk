TARGET_GAPPS_ARCH := arm64
include build/make/target/product/aosp_arm64.mk
$(call inherit-product, device/samsung/a55x/base.mk)
$(call inherit-product, vendor/aosp/config/common_full_phone.mk)
$(call inherit-product, device/lineage/sepolicy/common/sepolicy.mk)
$(call inherit-product, vendor/aosp/config/BoardConfigSoong.mk)

# Kernel
TARGET_NO_KERNEL_OVERRIDE := true
TARGET_NO_KERNEL_IMAGE := true

# for EROFS
GSI_FILE_SYSTEM_TYPE := erofs
BOARD_EROFS_COMPRESSOR := lz4hc,9

# Bootanimation
TARGET_BOOT_ANIMATION_RES := 1080

# Screen Resolution
TARGET_SCREEN_HEIGHT := 2340
TARGET_SCREEN_WIDTH := 1080

# ???
WITH_ADB_INSECURE := true
PRODUCT_OTA_ENFORCE_VINTF_KERNEL_REQUIREMENTS := false
override TARGET_SUPPORTS_64_BIT_APPS := true # To enable Face Unlock. Override seems to be required.
override BUILD_BROKEN_ELF_PREBUILT_PRODUCT_COPY_FILES := true

# SELinux
TARGET_USES_PREBUILT_VENDOR_SEPOLICY := true

# Additional packages
PRODUCT_PACKAGES += \
  OpenEUICC
