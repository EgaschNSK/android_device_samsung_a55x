$(call inherit-product, device/mytja/pixelos/device.mk)

PRODUCT_NAME := pixelos

GSI_FILE_SYSTEM_TYPE := erofs
BOARD_EROFS_COMPRESSOR := lz4hc,9
TARGET_PRODUCT_PROP += device/samsung/universal1480-common/product.prop
