
FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"
SRC_URI = "git://github.com/Nuvoton-Israel/entity-manager.git"
SRCREV = "${AUTOREV}"
SRC_URI += " \
           file://F0B_BMC_BMC.json \
           "
FILES_${PN} += " ${datadir}/entity-manager/F0B_BMC_BMC.json"

EXTRA_OECMAKE += " -DUSE_16BIT_ADDR=1"

do_install_append() {
    install -d ${D}${datadir}/entity-manager
    install -m 0644 -D ${WORKDIR}/F0B_BMC_BMC.json \
        ${D}${datadir}/entity-manager/configurations/F0B_BMC_BMC.json
}
