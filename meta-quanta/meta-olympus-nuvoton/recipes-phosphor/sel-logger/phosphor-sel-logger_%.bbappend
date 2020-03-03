FILESEXTRAPATHS_append_olympus-nuvoton := "${THISDIR}/${PN}:"

DEPENDS_append_olympus-nuvoton = " phosphor-dbus-interfaces"

# SRC_URI_append_olympus-nuvoton = " file://0001-add-sensor-evnet-log-support.patch"
SRC_URI_append_olympus-nuvoton = " file://0001-add-event-log-support.patch"
SRC_URI_append_olympus-nuvoton = " file://xyz.openbmc_project.Logging.IPMI.service"

# Enable threshold monitoring
EXTRA_OECMAKE_append = " -DSEL_LOGGER_MONITOR_THRESHOLD_EVENTS=ON \
    -DREDFISH_LOG_MONITOR_EVENTS_LOG=ON \
"

do_install_append_olympus-nuvoton() {
    install -d ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/xyz.openbmc_project.Logging.IPMI.service \
        ${D}${systemd_unitdir}/system
}
