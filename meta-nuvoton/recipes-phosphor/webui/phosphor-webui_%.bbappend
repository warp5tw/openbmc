FILESEXTRAPATHS_append_nuvoton := ":${THISDIR}/${PN}"

SRC_URI_append_nuvoton = " \
    file://0001-novnc-add-16-bit-hextile-support-for-nuvoton-ece-eng.patch \
"
