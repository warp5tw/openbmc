FILESEXTRAPATHS_prepend_buv-test := "${THISDIR}/linux-nuvoton:"

SRC_URI_append_buv-test = " file://buv-runbmc.cfg"
SRC_URI_append_buv-test = " \
  file://0001-dts-nuvoton-add-buv-runbmc-support.patch \
  file://0002-move-emc-debug-message-to-dev_dbg.patch \
  file://0004-add-seven_seg_gpio.patch \
  file://0005-misc-Character-device-driver.patch \
  file://0006-driver-SPI-add-w25q01jv-support.patch \
  "
