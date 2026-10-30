### AnyKernel3 Ramdisk Mod Script - Redmi 4A (rolex) / 5A (riva), crDroid "rova"
### Based on osm0sis' AnyKernel3 template

### AnyKernel setup
# global properties
properties() { '
kernel.string=rova custom kernel (BakaSU + Droidspaces)
do.devicecheck=0
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=rolex
device.name2=riva
device.name3=rova
device.name4=
device.name5=
supported.versions=
supported.patchlevels=
supported.vendorpatchlevels=
'; } # end properties


### AnyKernel install
## boot files attributes
boot_attributes() {
set_perm_recursive 0 0 755 644 $RAMDISK/*;
set_perm_recursive 0 0 750 750 $RAMDISK/init* $RAMDISK/sbin;
} # end attributes

# boot shell variables
BLOCK=/dev/block/bootdevice/by-name/boot;
IS_SLOT_DEVICE=0;
RAMDISK_COMPRESSION=auto;
PATCH_VBMETA_FLAG=auto;

# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh;

# boot install: only swap the kernel (Image.gz-dtb), keep the existing ramdisk
split_boot;
flash_boot;
## end boot install
