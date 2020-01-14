FILESEXTRAPATHS_prepend_runbmc-buv := "${THISDIR}/${PN}:"

SRC_URI_append_runbmc-buv = " file://fw_env.config"

do_install_append_runbmc-buv () {
	install -m 644 ${WORKDIR}/fw_env.config ${D}${sysconfdir}/fw_env.config
}
