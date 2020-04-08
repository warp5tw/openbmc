FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

inherit obmc-phosphor-systemd

SRC_URI_append_olympus-nuvoton = " file://power-supply-monitor@.service" 
SRC_URI_append_olympus-nuvoton = " file://psu.json" 
SRC_URI_append_olympus-nuvoton = " file://0001-port-phosphor-power-onto-Olympus.patch"

PSU_MONITOR_ENV_FMT_append_olympus-nuvoton = "obmc/power-supply-monitor/power-supply-monitor-{0}.conf"

SYSTEMD_ENVIRONMENT_FILE_${PN}_append_olympus-nuvoton += "${@compose_list(d, 'PSU_MONITOR_ENV_FMT', 'OBMC_POWER_SUPPLY_INSTANCES')}"

FILES_${PN}_append_olympus-nuvoton += "${datadir}/phosphor-power/psu.json"

do_install_append() {

    install -D ${WORKDIR}/power-supply-monitor@.service ${D}${systemd_unitdir}/system/power-supply-monitor@.service

    install -D ${WORKDIR}/psu.json ${D}${datadir}/phosphor-power/psu.json
}

