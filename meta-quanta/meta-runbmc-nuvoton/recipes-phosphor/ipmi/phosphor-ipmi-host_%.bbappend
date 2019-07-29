SRC_URI_remove = "git://github.com/openbmc/phosphor-host-ipmid"
SRC_URI_prepend = "git://github.com/Nuvoton-Israel/phosphor-host-ipmid"

SRCREV := "fc57f58936f1af5b94c25d113ef92932efb2ebc9"

FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"
