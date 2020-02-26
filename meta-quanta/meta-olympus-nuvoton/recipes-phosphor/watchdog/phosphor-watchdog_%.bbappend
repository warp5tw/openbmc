FILESEXTRAPATHS_prepend_olympus-nuvoton := "${THISDIR}/${PN}:"

SRC_URI_append_olympus-nuvoton = " file://obmc-enable-host-watchdog@.service"

do_install_append_olympus-nuvoton() {
    install -d ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/obmc-enable-host-watchdog@.service \
        ${D}${systemd_unitdir}/system
}
