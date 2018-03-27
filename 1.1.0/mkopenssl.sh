#!/bin/bash

export ANDROID_NDK=~/Android/Sdk/ndk-bundle
T_VERSION=4.9

T_ARCH=$1

case $T_ARCH in
        arm)
          T_ABI=eabi
          T_API=14
          T_TARGET=android-armeabi
          T_ARCH_ABI=$T_ARCH-linux-android$T_ABI
          export PATH=$PATH:$ANDROID_NDK/toolchains/$T_ARCH_ABI-$T_VERSION/prebuilt/linux-x86_64/bin
          export CROSS_SYSROOT=$ANDROID_NDK/platforms/android-$T_API/arch-arm
          T_ARM_MAX="-D__ARM_MAX_ARCH__=8"
          ;;
        x86)
          T_API=14
          T_TARGET=android-x86
          T_ARCH_ABI=i686-linux-android
          export PATH=$PATH:$ANDROID_NDK/toolchains/x86-$T_VERSION/prebuilt/linux-x86_64/bin
          export CROSS_SYSROOT=$ANDROID_NDK/platforms/android-$T_API/arch-x86
          ;;
        aarch64)
          T_API=21
          T_TARGET=android64-aarch64
          T_ARCH_ABI=$T_ARCH-linux-android
          export PATH=$PATH:$ANDROID_NDK/toolchains/$T_ARCH_ABI-$T_VERSION/prebuilt/linux-x86_64/bin
          export CROSS_SYSROOT=$ANDROID_NDK/platforms/android-$T_API/arch-arm64
          ;;
        x86_64)
          T_API=21
          T_TARGET=android64-x86
          T_ARCH_ABI=$T_ARCH-linux-android
          export PATH=$PATH:$ANDROID_NDK/toolchains/x86_64-$T_VERSION/prebuilt/linux-x86_64/bin
          export CROSS_SYSROOT=$ANDROID_NDK/platforms/android-$T_API/arch-x86_64
          ;;
        *)
          echo "ERROR ERROR ERROR"
          exit 1
          ;;
esac

mkdir -p builds
rm -rf builds/$T_ARCH
mkdir builds/$T_ARCH
cd builds/$T_ARCH

export CROSS_COMPILE=$T_ARCH_ABI-
export ANDROID_ISYSROOT="$ANDROID_NDK/sysroot/usr/include"
export CROSS_ISYSROOT="-I$ANDROID_ISYSROOT -I$ANDROID_ISYSROOT/$T_ARCH_ABI -D__ANDROID_API__=$T_API $T_ARM_MAX"
perl ../../openssl-1.1.0g/Configure no-shared $T_TARGET
make

