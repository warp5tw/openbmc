FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"
SRC_URI += " \
           file://F0B_BMC_MB.json \
           file://xyz.openbmc_project.EntityManager.service \
		   file://xyz.openbmc_project.FruDevice.service \
           "
FILES_${PN} += " ${datadir}/entity-manager/F0B_BMC_MB.json \
               "
do_install_append() {
    install -d ${D}${datadir}/entity-manager
    install -m 0644 -D ${WORKDIR}/F0B_BMC_MB.json \
        ${D}${datadir}/entity-manager/configurations/F0B_BMC_MB.json
    install -m 644 ${WORKDIR}/xyz.openbmc_project.EntityManager.service ${D}${systemd_system_unitdir}/
    install -m 644 ${WORKDIR}/xyz.openbmc_project.FruDevice.service ${D}${systemd_system_unitdir}/
}
