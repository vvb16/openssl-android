#!/bin/bash

export ANDROID_NDK=~/android-toolchains

T_ARCH=$1

case $T_ARCH in
        arm)
#
# ~/Android/Sdk/ndk-bundle/build/tools/make_standalone_toolchain.py --arch arm --api 14 --install-dir ~/android-toolchains/arm
#
          T_API=14
          T_ARCH_ABI=$T_ARCH-linux-androideabi
          T_TARGET=android-armeabi
          ;;
        x86)
#
# ~/Android/Sdk/ndk-bundle/build/tools/make_standalone_toolchain.py --arch x86 --api 14 --install-dir ~/android-toolchains/x86
#
          T_API=14
          T_TARGET=android-x86
          T_ARCH_ABI=i686-linux-android
          ;;
        aarch64)
#
# ~/Android/Sdk/ndk-bundle/build/tools/make_standalone_toolchain.py --arch arm64 --api 21 --install-dir ~/android-toolchains/aarch64
#
          T_API=21
          T_TARGET=android64-aarch64
          T_ARCH_ABI=$T_ARCH-linux-android
          ;;
        x86_64)
#
# ~/Android/Sdk/ndk-bundle/build/tools/make_standalone_toolchain.py --arch x86_64 --api 21 --install-dir ~/android-toolchains/x86_64
#
          T_API=21
          T_TARGET=android64-x86
          T_ARCH_ABI=$T_ARCH-linux-android
          ;;
        *)
          echo "ERROR ERROR ERROR"
          exit 1
          ;;
esac

export PATH=$PATH:$ANDROID_NDK/$T_ARCH/bin
export CROSS_SYSROOT=$ANDROID_NDK/$T_ARCH/sysroot

mkdir -p builds
rm -rf builds/$T_ARCH
mkdir builds/$T_ARCH
cd builds/$T_ARCH

export CROSS_COMPILE=$T_ARCH_ABI-
#export ANDROID_ISYSROOT="$ANDROID_NDK/sysroot/usr/include"
perl ../../openssl-1.1.0g/Configure no-shared $T_TARGET
make

