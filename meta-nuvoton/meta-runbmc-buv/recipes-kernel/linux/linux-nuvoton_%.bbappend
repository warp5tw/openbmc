FILESEXTRAPATHS_prepend_runbmc-buv := "${THISDIR}/linux-nuvoton:"

SRC_URI_append_runbmc-buv = " file://runbmc-buv.cfg"
SRC_URI_append_runbmc-buv = " file://0001-dts-nuvoton-add-runbmc-buv-board-support.patch"
