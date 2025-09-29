#
# Copyright (C) 2024 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# inherit from a55x device
$(call inherit-product, device/samsung/a55x/device.mk)

# Overwrite the inherited "emulator" characteristics
PRODUCT_CHARACTERISTICS := device

PRODUCT_NAME := a55x
PRODUCT_DEVICE := a55x
PRODUCT_MANUFACTURER := samsung
PRODUCT_BRAND := samsung
PRODUCT_SYSTEM_MANUFACTURER := samsung
PRODUCT_SYSTEM_BRAND := samsung

PRODUCT_GMS_CLIENTID_BASE := android-samsung-ss
PRODUCT_SYSTEM_NAME := a55xnaxx
PRODUCT_SYSTEM_DEVICE := a55

# BUILD_FINGERPRINT := samsung/a55xnaxx/a55x:14/UP1A.231005.007/A556BXXU4AXH1:user/release-keys
