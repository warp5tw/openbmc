SRC_URI_remove = "git://github.com/openbmc/phosphor-host-ipmid"
SRC_URI_prepend = "git://github.com/Nuvoton-Israel/phosphor-host-ipmid"

SRCREV := "425ad3786e8a9b54d61407fef0dcb799d493cfae"

FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"
