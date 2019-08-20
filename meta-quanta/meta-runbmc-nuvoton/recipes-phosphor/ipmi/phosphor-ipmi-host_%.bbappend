SRC_URI_remove = "git://github.com/openbmc/phosphor-host-ipmid"
SRC_URI_prepend = "git://github.com/Nuvoton-Israel/phosphor-host-ipmid"

SRCREV := "${AUTOREV}"

FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

DEPENDS_append_runbmc-nuvoton = " runbmc-nuvoton-yaml-config"

EXTRA_OECONF_runbmc-nuvoton = " \
    SENSOR_YAML_GEN=${STAGING_DIR_HOST}${datadir}/runbmc-nuvoton-yaml-config/ipmi-sensors.yaml \
    INVSENSOR_YAML_GEN=${STAGING_DIR_HOST}${datadir}/runbmc-nuvoton-yaml-config/ipmi-inventory-sensors.yaml \
    FRU_YAML_GEN=${STAGING_DIR_HOST}${datadir}/runbmc-nuvoton-yaml-config/ipmi-fru-read.yaml \
    "

SRC_URI_append = " file://phosphor-ipmi-host.service"
SRC_URI_append = " file://xyz.openbmc_project.Ipmi.Internal.SoftPowerOff.service"

SYSTEMD_SERVICE_${PN}_append = " phosphor-ipmi-host.service"
SYSTEMD_SERVICE_${PN}_append = " xyz.openbmc_project.Ipmi.Internal.SoftPowerOff.service"

do_install_append() {
    install -d ${D}${systemd_unitdir}/system/
    install -m 0644 ${WORKDIR}/phosphor-ipmi-host.service \
        ${D}${systemd_unitdir}/system
    install -m 0644 ${WORKDIR}/xyz.openbmc_project.Ipmi.Internal.SoftPowerOff.service \
        ${D}${systemd_unitdir}/system
}
