#
# Copyright (rc4) 2014 The CyanogenMod Project
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

LOCAL_PATH := device/samsung/matissewifi

# Assert
TARGET_OTA_ASSERT_DEVICE := matissewifi,matisselte,matisse3g

# Kernel
TARGET_KERNEL_SOURCE := kernel/samsung/matissewifi
#TARGET_KERNEL_CONFIG := msm8226-twrp_defconfig

TARGET_KERNEL_CONFIG := msm8226-sec_defconfig
TARGET_KERNEL_VARIANT_CONFIG := msm8226-sec_matissewifi_defconfig
BOARD_MKBOOTIMG_ARGS := --ramdisk_offset 0x02000000 --tags_offset 0x1e00000
BOARD_CUSTOM_BOOTIMG_MK := $(LOCAL_PATH)/mkbootimg.mk
#CONFIG_CROSS_COMPILE3 := /home/sub77/Android/toolchains/sabermod/SaberNaro-arm-eabi-4.1/bin/arm-eabi-

# Init
TARGET_INIT_VENDOR_LIB := libinit_msm
TARGET_LIBINIT_DEFINES_FILE := $(LOCAL_PATH)/init/init_matissewifi.c
TARGET_UNIFIED_DEVICE := true

# Partitions
BOARD_FLASH_BLOCK_SIZE := 131072
BOARD_BOOTIMAGE_PARTITION_SIZE := 10485760
BOARD_RECOVERYIMAGE_PARTITION_SIZE := 10485760
BOARD_SYSTEMIMAGE_PARTITION_SIZE := 2411724800
BOARD_USERDATAIMAGE_PARTITION_SIZE := 12759776768
TARGET_USERIMAGES_USE_EXT4 := true

# Radio
BOARD_RIL_CLASS := ../../../device/samsung/matissewifi/ril/

# Releasetools
TARGET_RELEASETOOLS_EXTENSIONS := device/samsung/matissewifi

# Recovery
TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/rootdir/etc/fstab.qcom
#TARGET_RECOVERY_FSTAB := $(LOCAL_PATH)/multirom/twrp.fstab
DEVICE_RESOLUTION := 1280x800

#TWRP
#LZMA
#RECOVERY_VARIANT := twrp
TW_MATISSEWIFI := true
TW_BRIGHTNESS_PATH := /sys/class/leds/lcd-backlight/brightness
TW_MAX_BRIGHTNESS := 126
TW_IGNORE_MAJOR_AXIS_0 := true
RECOVERY_GRAPHICS_USE_LINELENGTH := true
TW_NO_USB_STORAGE := true
BOARD_HAS_NO_REAL_SDCARD := true
RECOVERY_SDCARD_ON_DATA := true
TW_USE_TOOLBOX := true
TW_EXCLUDE_SUPERSU := true
TWHAVE_SELINUX := true
#TW_INCLUDE_L_CRYPTO := true

# MultiROM config. MultiROM also uses parts of TWRP config
#MR_INPUT_TYPE := type_b
#MR_INIT_DEVICES := device/samsung/matissewifi/multirom/mr_init_devices.c
#MR_DPI := hdpi
#MR_DPI_FONT := 160
#MR_FSTAB := device/samsung/matissewifi/multirom/twrp.fstab
#MR_KEXEC_MEM_MIN := 0x05000000
#MR_USE_MROM_FSTAB := true
#MR_DEVICE_HOOKS := device/samsung/matissewifi/multirom/mr_hooks.c
#MR_DEVICE_HOOKS_VER := 1
#MR_KEXEC_DTB := true
#MR_INFOS := device/samsung/matissewifi/mrom_infos
#MR_CONTINUOUS_FB_UPDATE := true

# Use retire fence from MDP driver
TARGET_DISPLAY_USE_RETIRE_FENCE := true

# Enable dex-preoptimization to speed up first boot sequence
ifeq ($(HOST_OS),linux)
  ifeq ($(TARGET_BUILD_VARIANT),user,userdebug)
    ifeq ($(WITH_DEXPREOPT),)
      WITH_DEXPREOPT := true
      WITH_DEXPREOPT_BOOT_IMG_ONLY := false
    endif
  endif
endif
WITH_DEXPREOPT_BOOT_IMG_ONLY ?= true

# inherit from the proprietary version
-include vendor/samsung/matissewifi/BoardConfigVendor.mk
