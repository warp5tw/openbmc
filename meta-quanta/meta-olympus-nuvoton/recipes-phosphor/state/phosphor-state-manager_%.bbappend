FILESEXTRAPATHS_prepend_olympus-nuvoton := "${THISDIR}/${PN}:"

SRC_URI_append_olympus-nuvoton = " file://0001-Read-power-state-from-PCH-for-host-state.patch"
SRC_URI_append_olympus-nuvoton = " file://phosphor-reset-host-check@.service"

SYSTEMD_SERVICE_${PN}_append_olympus-nuvoton = " phosphor-reset-host-check@.service"

DEPENDS += "i2c-tools"

do_install_append_olympus-nuvoton() {
    install -d ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/phosphor-reset-host-check@.service \
        ${D}${systemd_unitdir}/system
}
