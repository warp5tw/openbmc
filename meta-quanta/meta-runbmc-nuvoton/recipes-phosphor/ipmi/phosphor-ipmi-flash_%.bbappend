FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
EXTRA_OECONF_append = " --enable-static-layout"
EXTRA_OECONF_append = " --enable-lpc-bridge"
EXTRA_OECONF_append = " --enable-nuvoton-lpc"
EXTRA_OECONF_append = " --enable-reboot-update"
EXTRA_OECONF_append = " MAPPED_ADDRESS=0xc0008000"

