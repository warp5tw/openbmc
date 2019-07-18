FILESEXTRAPATHS_prepend_runbmc-nuvoton := "${THISDIR}/${PN}:"

SRC_URI_append_runbmc-nuvoton = " file://fw_env.config"

do_install_append_runbmc-nuvoton () {
    install -m 644 ${WORKDIR}/fw_env.config ${D}${sysconfdir}/fw_env.config
}

SRCREV = "6e289d885d18bfb9a541c92fbc10e841210bd9de"
