FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

SRCREV = "2cdc49585235a6557c9cbb6c8b75c064fc02681a"
SRC_URI += " \
           file://0001-runbmc-kcsbridged.patch \
           "

