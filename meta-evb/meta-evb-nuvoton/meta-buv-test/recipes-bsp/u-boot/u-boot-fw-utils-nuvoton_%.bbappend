FILESEXTRAPATHS_prepend_buv-test := "${THISDIR}/${PN}:"

SRCREV = "a386041c45fa11b4f7f066f07b0f4446c1daaee1"
SRC_URI_append_buv-test = " file://fw_env.config"

do_install_append_buv-test () {
	install -m 644 ${WORKDIR}/fw_env.config ${D}${sysconfdir}/fw_env.config
}
