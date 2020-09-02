FILESEXTRAPATHS_prepend_buv-test := "${THISDIR}/u-boot-nuvoton:"

UBOOT_MAKE_TARGET_append_buv-test = " DEVICE_TREE=${UBOOT_DEVICETREE}"

SRC_URI_append_buv-test = " file://fixed_phy.cfg"
