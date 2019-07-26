FILESEXTRAPATHS_prepend_runbmc-nuvoton := "${THISDIR}/${BPN}:"
SRC_URI_append_runbmc-nuvoton = " file://time-default.override.yml"
