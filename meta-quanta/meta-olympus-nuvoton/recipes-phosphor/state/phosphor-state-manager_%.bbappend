FILESEXTRAPATHS_prepend_olympus-nuvoton := "${THISDIR}/${PN}:"

SRC_URI_append_olympus-nuvoton = " file://0001-fix-host-power-state-inconsisent-issue.patch"
SRC_URI_append_olympus-nuvoton = " file://0001-add-default-state-for-ProgressStages-and-OSStatus.patch"

do_install__append_olympus-nuvoton() {
    rm -f ${D}${systemd_unitdir}/system/phosphor-reset-sensor-states@.service
    rm -f ${D}${systemd_unitdir}/system/phosphor-reset-host-check@.service
}