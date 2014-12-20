# Inherit CM common Phone stuff.
$(call inherit-product, vendor/omni/config/common_tablet.mk)

# Release name
PRODUCT_RELEASE_NAME := ms013g

$(call inherit-product, device/samsung/ms013g/full_ms013g.mk)

PRODUCT_NAME := omni_ms013g
PRODUCT_DEVICE := ms013g

