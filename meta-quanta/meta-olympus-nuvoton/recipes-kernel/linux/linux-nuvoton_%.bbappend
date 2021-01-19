FILESEXTRAPATHS_prepend := "${THISDIR}/linux-nuvoton:"

SRC_URI_append_olympus-nuvoton = " file://olympus-nuvoton.cfg"
SRC_URI_append_olympus-nuvoton = " file://vlan.cfg"
SRC_URI_append_olympus-nuvoton = " file://i2c_mux_pinctrl.cfg"
SRC_URI_append_olympus-nuvoton = " file://0001-add-i2c-mux-pinctrl-support-on-Olympus.patch"
