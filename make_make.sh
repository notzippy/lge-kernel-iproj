#!/bin/bash

#!/bin/bash
DEFCONFIG_FILE=$1
MY_CROSS_COMPILE=/home/homeu1/work/builds/android/p930/cm11/prebuilts/gcc/linux-x86/arm/arm-linux-androideabi-4.6/bin/arm-linux-androideabi-

if [ -z "$DEFCONFIG_FILE" ]; then
    echo "Need defconfig file(j1v-perf_defconfig)!"
    exit -1
fi

if [ ! -e arch/arm/configs/$DEFCONFIG_FILE ]; then
    echo "No such file : arch/arm/configs/$DEFCONFIG_FILE"
    exit -1
fi

# make .config
env KCONFIG_NOTIMESTAMP=true \
make ARCH=arm CROSS_COMPILE=${MY_CROSS_COMPILE} ${DEFCONFIG_FILE}

make -j6 ARCH=arm CROSS_COMPILE=${MY_CROSS_COMPILE}


rm ../p930_output/*
cp arch/arm/boot/zImage ../p930_output/zImage
find . -name "*.ko" -exec cp {} ../p930_output \;

read "Clean project ?"
# clean kernel object
make mrproper
