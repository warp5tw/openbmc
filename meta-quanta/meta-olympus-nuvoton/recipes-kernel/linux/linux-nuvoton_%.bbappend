FILESEXTRAPATHS_prepend := "${THISDIR}/linux-nuvoton:"

SRC_URI_append_olympus-nuvoton = " file://olympus-nuvoton.cfg"
SRC_URI_append_olympus-nuvoton = " file://vlan.cfg"
SRC_URI_append_olympus-nuvoton = " file://0002-Ampere-Altra-MAX-SSIF-IPMI-driver.patch"
SRC_URI_append_olympus-nuvoton = " file://0001-add-ssif-device-on-i2c-bus-6.patch"

