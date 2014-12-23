#
# Copyright (C) 2014 The CyanogenMod Project
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

# inherit from common msm8226-common
-include device/samsung/msm8226-common/BoardConfigCommon.mk

LOCAL_PATH := device/samsung/ms013g

# Assert
TARGET_OTA_ASSERT_DEVICE := matissewifi,ms013g,ms013gxx,ms01lte

# Kernel
TARGET_KERNEL_SOURCE := kernel/samsung/ms013g
TARGET_KERNEL_CONFIG := cm_matissewifi_defconfig 
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x02000000 --tags_offset 0x1e00000
BOARD_CUSTOM_BOOTIMG_MK := $(LOCAL_PATH)/mkbootimg.mk

WLAN_MODULES:
	mkdir -p $(KERNEL_MODULES_OUT)/pronto
	mv $(KERNEL_MODULES_OUT)/wlan.ko $(KERNEL_MODULES_OUT)/pronto/pronto_wlan.ko
	ln -sf /system/lib/modules/pronto/pronto_wlan.ko $(TARGET_OUT)/lib/modules/wlan.ko

TARGET_KERNEL_MODULES += WLAN_MODULES

# Init
TARGET_INIT_VENDOR_LIB := libinit_msm
TARGET_LIBINIT_DEFINES_FILE := $(LOCAL_PATH)/init/init_ms013g.c
TARGET_UNIFIED_DEVICE := true

# Partitions
BOARD_BOOTIMAGE_PARTITION_SIZE := 10485760
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 19485760
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 1866465280
BOARD_USERDATAIMAGE_PARTITION_SIZE := 5555010560
BOARD_CACHEIMAGE_PARTITION_SIZE := 218103808
BOARD_FLASH_BLOCK_SIZE := 131072
TARGET_USERIMAGES_USE_EXT4 := true

# Radio
BOARD_RIL_CLASS := ../../../device/samsung/ms013g/ril/

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := device/samsung/ms013g

# Disable initlogo, Samsungs framebuffer is weird
#TARGET_NO_INITLOGO := true

# Recovery
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/rootdir/etc/fstab.qcom

#TWRP
DEVICE_RESOLUTION := 1280x800
TARGET_RECOVERY_PIXEL_FORMAT := "RGBX_8888"
#TW_BRIGHTNESS_PATH := /sys/class/backlight/lcd-backlight/brightness
#TW_MAX_BRIGHTNESS := 126
TW_IGNORE_MAJOR_AXIS_0 := true
RECOVERY_GRAPHICS_USE_LINELENGTH := true
TW_NO_USB_STORAGE := false
TW_NO_SCREEN_TIMEOUT := true
TW_NO_SCREEN_BLANK := true
TW_INTERNAL_STORAGE_PATH := "/data/media"
TW_INTERNAL_STORAGE_MOUNT_POINT := "data"
TW_EXTERNAL_STORAGE_PATH := "/sdcard"
TW_EXTERNAL_STORAGE_MOUNT_POINT := "sdcard"
BOARD_HAS_NO_REAL_SDCARD := false
RECOVERY_SDCARD_ON_DATA := true
HAVE_SELINUX := true
TW_INCLUDE_L_CRYPTO := true

PRODUCT_COPY_FILES += \
$(LOCAL_PATH)/twrp.fstab:recovery/root/etc/twrp.fstab

# Enable dex-preoptimization to speed up first boot sequence
ifeq ($(HOST_OS),linux)
ifeq ($(TARGET_BUILD_VARIANT),user)
ifeq ($(WITH_DEXPREOPT),)
WITH_DEXPREOPT := true
WITH_DEXPREOPT_BOOT_IMG_ONLY := false
endif
endif
endif
WITH_DEXPREOPT_BOOT_IMG_ONLY ?= true

# inherit from the proprietary version
-include vendor/samsung/ms013g/BoardConfigVendor.mk
