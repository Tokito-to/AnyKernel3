### AnyKernel3 Ramdisk Mod Script
## osm0sis @ xda-developers

### AnyKernel setup
# global properties
properties() { '
kernel.string=E404 Kernel by Tokito
do.devicecheck=1
do.modules=0
do.systemless=1
do.cleanup=1
do.cleanuponabort=0
device.name1=munch
supported.versions=11 - 15
supported.patchlevels=
supported.vendorpatchlevels=
'; } # end properties

### AnyKernel install
## boot files attributes
boot_attributes() {
set_perm_recursive 0 0 755 644 $RAMDISK/*;
set_perm_recursive 0 0 750 750 $RAMDISK/init* $RAMDISK/sbin;
}

# boot shell variables
BLOCK=/dev/block/bootdevice/by-name/boot;
IS_SLOT_DEVICE=1;
RAMDISK_COMPRESSION=auto;
PATCH_VBMETA_FLAG=auto;

# import functions/variables and setup patching - see for reference (DO NOT REMOVE)
. tools/ak3-core.sh;

ui_print " ";
ui_print "Installing Kernel : "$ZIPFILE" ";
ui_print " ";

case "$ZIPFILE" in
    *ksu*|*KSU*)
        ui_print " • Using KSU variant";
        rm Image;
        mv ksu/Image $home/Image;
    ;;
    *)
        ui_print " • Using normal variant";
    ;;
esac

# boot install
dump_boot;
write_boot;

# boot shell variables
BLOCK=/dev/block/bootdevice/by-name/vendor_boot;
IS_SLOT_DEVICE=1;
RAMDISK_COMPRESSION=auto;
PATCH_VBMETA_FLAG=auto;

# reset for vendor_boot patching
reset_ak;

# vendor_boot install
dump_boot;
write_boot;
