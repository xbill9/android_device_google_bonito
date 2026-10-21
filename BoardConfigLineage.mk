#
# Copyright (C) 2020-2021 The LineageOS Project
#
# SPDX-License-Identifier: Apache-2.0
#

# Kernel
BOARD_KERNEL_IMAGE_NAME := Image.lz4
TARGET_COMPILE_WITH_MSM_KERNEL := true
TARGET_KERNEL_CLANG_VERSION := r416183b
TARGET_KERNEL_CLANG_PATH := $(abspath .)/prebuilts/clang/kernel/$(HOST_PREBUILT_TAG)/clang-$(TARGET_KERNEL_CLANG_VERSION)
TARGET_KERNEL_CONFIG := bonito_defconfig
TARGET_KERNEL_LLVM_BINUTILS := false
# 4.9 links LTO with GNU gold from CROSS_COMPILE; the 23.2 default adds LD=ld.lld, which overrides it
KERNEL_CC := CC=clang
TARGET_KERNEL_SOURCE := kernel/google/msm-4.9
TARGET_NEEDS_DTBOIMAGE := true

# Manifests

# Partitions
AB_OTA_PARTITIONS += \
    vendor
ifneq ($(PRODUCT_USE_DYNAMIC_PARTITIONS), true)
    BOARD_VENDORIMAGE_PARTITION_SIZE := 805306368
endif
BOARD_VENDORIMAGE_FILE_SYSTEM_TYPE := ext4

# Reserve space for gapps install
-include vendor/lineage/config/BoardConfigReservedSize.mk
ifneq ($(WITH_GMS),true)
# 900 MiB: Android 16 images no longer fit super with the 1000 MiB reserve
BOARD_PRODUCTIMAGE_PARTITION_RESERVED_SIZE := 943718400
endif

# SELinux
BOARD_SEPOLICY_DIRS += device/google/bonito/sepolicy-lineage/dynamic
BOARD_SEPOLICY_DIRS += device/google/bonito/sepolicy-lineage/vendor

# Verified Boot
BOARD_AVB_MAKE_VBMETA_IMAGE_ARGS += --flags 3
