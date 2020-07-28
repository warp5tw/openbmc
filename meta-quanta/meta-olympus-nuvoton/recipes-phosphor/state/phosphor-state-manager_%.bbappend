FILESEXTRAPATHS_prepend_olympus-nuvoton := "${THISDIR}/${PN}:"

SRC_URI_append_olympus-nuvoton = " file://0001-Use-pgood-to-check-host-stat.patch"
SRC_URI_append_olympus-nuvoton = " file://phosphor-reset-host-check@.service"

SYSTEMD_SERVICE_${PN}_append_olympus-nuvoton = " phosphor-reset-host-check@.service"

HOST_SHUT_TMPL = "obmc-host-shutdown@{0}.target"
HOST_WARMREBOOT_TGTFMT = "obmc-host-warm-reboot@{0}.target"
HOST_SHUT_FMT = "../${HOST_SHUT_TMPL}:${HOST_WARMREBOOT_TGTFMT}.requires/${HOST_SHUT_TMPL}"
SYSTEMD_LINK_${PN}-host += "${@compose_list(d, 'HOST_SHUT_FMT', 'OBMC_HOST_INSTANCES')}"

SYSTEMD_LINK_${PN}-host_remove = "${@compose_list_zip(d, 'HOST_WARM_REBOOT_SOFT_SVC_FMT', 'OBMC_HOST_INSTANCES')}"

DEPENDS += "i2c-tools"

do_install_append_olympus-nuvoton() {
    install -d ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/phosphor-reset-host-check@.service \
        ${D}${systemd_unitdir}/system
}
