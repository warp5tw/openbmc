FILESEXTRAPATHS_prepend_olympus-nuvoton := "${THISDIR}/${PN}:"

SRC_URI_append_olympus-nuvoton = " file://F0B_BMC_MB.json"
SRC_URI_append_olympus-nuvoton = " file://xyz.openbmc_project.EntityManager.service"
SRC_URI_append_olympus-nuvoton = " file://xyz.openbmc_project.FruDevice.service"

FILES_${PN} += " ${datadir}/entity-manager/F0B_BMC_MB.json \
               "
do_install_append_olympus-nuvoton() {
    install -d ${D}${datadir}/entity-manager
    install -m 0644 -D ${WORKDIR}/F0B_BMC_MB.json \
        ${D}${datadir}/entity-manager/configurations/F0B_BMC_MB.json
    install -m 644 ${WORKDIR}/xyz.openbmc_project.EntityManager.service ${D}${systemd_system_unitdir}/
    install -m 644 ${WORKDIR}/xyz.openbmc_project.FruDevice.service ${D}${systemd_system_unitdir}/
}
