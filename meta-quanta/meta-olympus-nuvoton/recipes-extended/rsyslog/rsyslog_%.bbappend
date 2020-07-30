FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"


SRC_URI += "file://rsyslog.conf \
           file://rsyslog.logrotate \
           file://rotate-event-logs.service \
           file://rotate-event-logs.timer \
           file://rsyslog.service \
           file://server.conf \
"


PACKAGECONFIG_append = " imjournal"

do_install_append() {
        install -m 0644 ${WORKDIR}/rotate-event-logs.service ${D}${systemd_system_unitdir}
        install -m 0644 ${WORKDIR}/rotate-event-logs.timer ${D}${systemd_system_unitdir}
        install -m 0644 ${WORKDIR}/rsyslog.service \
                        ${D}${systemd_system_unitdir}/rsyslog.service
        rm ${D}${sysconfdir}/rsyslog.d/imjournal.conf
        install -m 0644 -D ${WORKDIR}/server.conf \
        ${D}${sysconfdir}/rsyslog.d/server.conf
}

SYSTEMD_SERVICE_${PN} += " rotate-event-logs.service rotate-event-logs.timer"
