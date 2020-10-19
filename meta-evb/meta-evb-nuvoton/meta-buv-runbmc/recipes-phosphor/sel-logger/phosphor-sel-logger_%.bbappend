FILESEXTRAPATHS_append_buv-runbmc := "${THISDIR}/${PN}:"

DEPENDS_append_buv-runbmc = " phosphor-dbus-interfaces"

SRCREV := "df7bc1c6951fb7dd2776008aa0b7dc6bea44bed4"

SRC_URI_append_buv-runbmc = " file://0001-Revert-match-thresholdAsserted-signal-for-threshold-.patch"
SRC_URI_append_buv-runbmc = " file://xyz.openbmc_project.Logging.IPMI.service"

# Enable threshold monitoring
EXTRA_OECMAKE_append_buv-runbmc = " -DSEL_LOGGER_MONITOR_THRESHOLD_EVENTS=ON \
"
do_install_append_buv-runbmc() {
    install -d ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/xyz.openbmc_project.Logging.IPMI.service \
        ${D}${systemd_unitdir}/system
}
