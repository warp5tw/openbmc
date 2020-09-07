FILESEXTRAPATHS_prepend_olympus-nuvoton := "${THISDIR}/${PN}:"

SRC_URI_append_olympus-nuvoton = " file://0001-Nuvoton-PCIE-support-for-Intel-MCTP-library.patch "

ALLOW_EMPTY_${PN} = "1"
