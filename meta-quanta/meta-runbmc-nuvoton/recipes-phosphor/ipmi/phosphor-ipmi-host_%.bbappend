SRC_URI_remove = "git://github.com/openbmc/phosphor-host-ipmid"
SRC_URI_prepend = "git://github.com/Nuvoton-Israel/phosphor-host-ipmid"
SRCREV := "${AUTOREV}"

FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"
