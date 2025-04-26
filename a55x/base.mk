# Huawei devices don't declare fingerprint and telephony hardware feature
# TODO: Proper detection
PRODUCT_COPY_FILES := \
    frameworks/native/data/etc/android.hardware.fingerprint.xml:system/etc/permissions/android.hardware.fingerprint.xml \
    frameworks/native/data/etc/android.hardware.telephony.gsm.xml:system/etc/permissions/android.hardware.telephony.gsm.xml \
    frameworks/native/data/etc/android.hardware.telephony.ims.xml:system/etc/permissions/android.hardware.telephony.ims.xml \
    frameworks/native/data/etc/android.hardware.bluetooth.xml:system/etc/permissions/android.hardware.bluetooth.xml \
    frameworks/native/data/etc/android.hardware.bluetooth_le.xml:system/etc/permissions/android.hardware.bluetooth_le.xml \
    frameworks/native/data/etc/android.hardware.usb.host.xml:system/etc/permissions/android.hardware.usb.host.xml \

# Bluetooth Audio (System-side HAL, sysbta)
PRODUCT_PACKAGES += \
    audio.sysbta.default \
    android.hardware.bluetooth.audio-service-system

PRODUCT_COPY_FILES += \
    device/samsung/a55x/bluetooth/audio/config/sysbta_audio_policy_configuration.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysbta_audio_policy_configuration.xml \
    device/samsung/a55x/bluetooth/audio/config/sysbta_audio_policy_configuration_7_0.xml:$(TARGET_COPY_OUT_SYSTEM)/etc/sysbta_audio_policy_configuration_7_0.xml

SYSTEM_EXT_PRIVATE_SEPOLICY_DIRS += device/samsung/a55x/sepolicy
PRODUCT_PACKAGE_OVERLAYS += device/samsung/a55x/overlay

$(call inherit-product, vendor/hardware_overlay/overlay.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/core_64_bit.mk)
$(call inherit-product, $(SRC_TARGET_DIR)/product/aosp_base_telephony.mk)

# Those overrides are here because Huawei's init read properties
# from /system/etc/prop.default, then /vendor/build.prop, then /system/build.prop
# So we need to set our props in prop.default
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    ro.build.version.sdk=$(PLATFORM_SDK_VERSION) \
    ro.build.version.codename=$(PLATFORM_VERSION_CODENAME) \
    ro.build.version.all_codenames=$(PLATFORM_VERSION_ALL_CODENAMES) \
    ro.build.version.release=$(PLATFORM_VERSION) \
    ro.build.version.security_patch=$(PLATFORM_SECURITY_PATCH) \
    ro.adb.secure=0 \
    ro.logd.auditd=true \
    ro.logd.kernel=true \

# Huawei HiSuite (also other OEM custom programs I guess) it's of no use in AOSP builds
PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    persist.sys.usb.config=adb

# VNDK config files
PRODUCT_COPY_FILES += \
    device/samsung/a55x/vndk-detect:system/bin/vndk-detect \
    device/samsung/a55x/vndk.rc:system/etc/init/vndk.rc

# Charger config files
PRODUCT_COPY_FILES += \
    device/samsung/a55x/charger.rc:system/etc/init/charger.rc

# Charger image
PRODUCT_PACKAGES += \
    product_charger_res_images

# USB Audio
PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/usb_audio_policy_configuration.xml:system/etc/usb_audio_policy_configuration.xml \
    device/samsung/a55x/files/fake_audio_policy_volume.xml:system/etc/fake_audio_policy_volume.xml \

# NFC:
#   Provide default libnfc-nci.conf file for devices that does not have one in
#   vendor/etc
PRODUCT_COPY_FILES += \
    device/samsung/a55x/nfc/libnfc-nci.conf:system/phh/libnfc-nci-oreo.conf

PRODUCT_COPY_FILES += \
    device/samsung/a55x/rw-system.sh:system/bin/rw-system.sh \
    device/samsung/a55x/phh/phh-on-boot.sh:system/bin/phh-on-boot.sh \
    device/samsung/a55x/phh/phh-on-data.sh:system/bin/phh-on-data.sh \
    device/samsung/a55x/phh/phh-prop-handler.sh:system/bin/phh-prop-handler.sh \
    device/samsung/a55x/fixSPL/getSPL.arm:system/bin/getSPL

PRODUCT_PACKAGES += \
    treble-environ-rc \

PRODUCT_PACKAGES += \
    bootctl \
    vintf

PRODUCT_PACKAGES += \
    simg2img_simple \
    lptools

ifneq (,$(wildcard external/exfat))
PRODUCT_PACKAGES += \
    mkfs.exfat \
    fsck.exfat
endif

PRODUCT_PACKAGES += \
    android.hidl.manager-V1.0-java

PRODUCT_COPY_FILES += \
    device/samsung/a55x/interfaces.xml:system/etc/permissions/interfaces.xml

PRODUCT_COPY_FILES += \
    device/samsung/a55x/files/samsung-gpio_keys.kl.raw:system/phh/samsung-gpio_keys.kl \
    device/samsung/a55x/files/samsung-sec_touchscreen.kl.raw:system/phh/samsung-sec_touchscreen.kl \
    device/samsung/a55x/files/samsung-sec_touchkey.kl.raw:system/phh/samsung-sec_touchkey.kl \
    device/samsung/a55x/files/samsung-9810-floating_feature.xml:system/phh/sam-9810-flo_feat.xml \
    device/samsung/a55x/files/samsung-sec_e-pen.idc:system/usr/idc/sec_e-pen.idc

SELINUX_IGNORE_NEVERALLOWS := true

# Universal NoCutoutOverlay
PRODUCT_PACKAGES += \
    NoCutoutOverlay

PRODUCT_PACKAGES += \
    lightsctl \
    lightsctl-aidl \
    uevent

PRODUCT_COPY_FILES += \
    device/samsung/a55x/files/adbd.rc:system/etc/init/adbd.rc

PRODUCT_PACKAGES += \
    Stk

PRODUCT_PACKAGES += \
    resetprop_phh

PRODUCT_COPY_FILES += \
    device/samsung/a55x/phh/phh-securize.sh:system/bin/phh-securize.sh \

PRODUCT_COPY_FILES += \
    device/samsung/a55x/remove-telephony.sh:system/bin/remove-telephony.sh \

PRODUCT_COPY_FILES += \
    frameworks/native/data/etc/android.software.secure_lock_screen.xml:system/etc/permissions/android.software.secure_lock_screen.xml \
    device/samsung/a55x/files/android.software.controls.xml:system/etc/permissions/android.software.controls.xml \

PRODUCT_COPY_FILES += \
    device/samsung/a55x/ld.config.26.txt:system/etc/ld.config.26.txt \

# Privapp-permissions whitelist for PhhTrebleApp
PRODUCT_COPY_FILES += \
    device/samsung/a55x/privapp-permissions-me.phh.treble.app.xml:system/etc/permissions/privapp-permissions-me.phh.treble.app.xml \
    device/samsung/a55x/sysconfig-me.phh.treble.app.xml:system/etc/sysconfig/sysconfig-me.phh.treble.app.xml

# Remote debugging
PRODUCT_COPY_FILES += \
    device/samsung/a55x/remote/dbclient:system/bin/dbclient \
    device/samsung/a55x/remote/phh-remotectl.rc:system/etc/init/phh-remotectl.rc \
    device/samsung/a55x/remote/phh-remotectl.sh:system/bin/phh-remotectl.sh \

PRODUCT_PACKAGES += \
    vr_hwc \
    curl \
    healthd \

PRODUCT_SYSTEM_DEFAULT_PROPERTIES += \
    debug.fdsan=warn_once \
    persist.sys.fflag.override.settings_provider_model=false \
    ro.setupwizard.mode=OPTIONAL \

PRODUCT_PRODUCT_PROPERTIES += \
    ro.setupwizard.mode=OPTIONAL \

# AOSP overlays
PRODUCT_PACKAGES += \
    NavigationBarMode2ButtonOverlay

PRODUCT_COPY_FILES += \
    device/samsung/a55x/overrides/nothing.txt:system/etc/smartpa_params/empty \

PRODUCT_COPY_FILES += \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration_7_0.xml:system/etc/a2dp_audio_policy_configuration_7_0.xml \
    frameworks/av/services/audiopolicy/config/a2dp_audio_policy_configuration.xml:system/etc/a2dp_audio_policy_configuration.xml \

include build/make/target/product/gsi_release.mk

# Protect deskclock from power save
PRODUCT_COPY_FILES += \
    device/samsung/a55x/files/com.android.deskclock_whitelist.xml:system/etc/sysconfig/com.android.deskclock_whitelist.xml

PRODUCT_PACKAGES += \
    evgrab \

PRODUCT_PACKAGES += \
    slsi-booted \
    Iwlan \
    QualifiedNetworksService \

# Two-pane layout in Settings
$(call inherit-product, $(SRC_TARGET_DIR)/product/window_extensions.mk)
PRODUCT_PRODUCT_PROPERTIES += \
    persist.settings.large_screen_opt.enabled=true

PRODUCT_EXTRA_VNDK_VERSIONS += 28 29
