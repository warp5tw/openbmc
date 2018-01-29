FILESEXTRAPATHS_prepend_ast2500 := "${THISDIR}/files:"

SRC_URI_append_ast2500 = " file://fw_env.config"
SRC_URI_append_ast2500 += "file://alt_fw_env.config"
SRC_URI_append_ast2500 += "file://76-mtd-partitions.rules"

do_install_append_ast2500() {
    if [ -e ${WORKDIR}/fw_env.config ] ; then
        install -d ${D}${sysconfdir}
        install -m 644 ${WORKDIR}/fw_env.config ${D}${sysconfdir}/fw_env.config
        install -m 644 ${WORKDIR}/alt_fw_env.config ${D}${sysconfdir}/alt_fw_env.config
    fi
	install -d ${D}/${base_libdir}/udev/rules.d/
        install ${WORKDIR}/76-mtd-partitions.rules ${D}/${base_libdir}/udev/rules.d/
}

BBCLASSEXTEND += "native"
