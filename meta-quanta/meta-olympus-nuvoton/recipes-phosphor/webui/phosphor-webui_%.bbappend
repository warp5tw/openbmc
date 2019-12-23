FILESEXTRAPATHS_append_olympus-nuvoton := ":${THISDIR}/${PN}"

SRC_URI_append_olympus-nuvoton = " \
    file://0001-Fixed-cannot-show-warning-high-and-critical-high.patch \
    file://0002-Modify-bios-update-confirm-dialogue.patch \
    file://0003-disable_show_delete_while_activating.patch \
	file://0004-novnc-add-16-bit-hextile-support-for-nuvoton-ece-eng.patch \
"
