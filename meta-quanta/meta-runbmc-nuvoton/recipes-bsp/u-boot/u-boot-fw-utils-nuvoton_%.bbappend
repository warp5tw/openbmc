FILESEXTRAPATHS_prepend_gsj := "${THISDIR}/${PN}:"

SRC_URI_append_gsj = " file://fw_env.config"

do_install_append_gsj () {
    install -m 644 ${WORKDIR}/fw_env.config ${D}${sysconfdir}/fw_env.config
}

SRCREV = "98c5c6b825c165502f02e8b2ea846d190be21268"
