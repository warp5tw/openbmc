FILESEXTRAPATHS_prepend_olympus-nuvoton := "${THISDIR}/${PN}:"

SRC_URI_append_olympus-nuvoton = " file://0001-fix-host-power-state-inconsisent-issue.patch"
SRC_URI_append_olympus-nuvoton = " file://0001-add-default-state-for-ProgressStages-and-OSStatus.patch"

SYSTEMD_SERVICE_${PN}-reset-sensor-states_remove_olympus-nuvoton = " phosphor-reset-sensor-states@.service"
SYSTEMD_SERVICE_${PN}-host-check_remove_olympus-nuvoton = " phosphor-reset-host-check@.service"

do_install_append_olympus-nuvoton() {
    rm -f ${D}${systemd_unitdir}/system/phosphor-reset-sensor-states@.service
    rm -f ${D}${systemd_unitdir}/system/phosphor-reset-host-check@.service
}
