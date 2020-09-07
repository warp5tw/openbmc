FILESEXTRAPATHS_prepend_olympus-nuvoton := "${THISDIR}/${PN}:"

SMBUS_BINDING = "pcie"

SRC_URI_append_olympus-nuvoton = " file://mctp_config.json"
SRC_URI_append_olympus-nuvoton = " file://0001-Add-MCTP-support-for-Olympus.patch"
SRC_URI_append_olympus-nuvoton = " file://xyz.openbmc_project.mctpd@.service"

do_install_prepend_olympus-nuvoton() {
    install -m 0644 -D ${WORKDIR}/xyz.openbmc_project.mctpd@.service\
        ${S}/service_files/xyz.openbmc_project.mctpd@.service
}

do_install_append_olympus-nuvoton() {
    install -m 0644 -D ${WORKDIR}/mctp_config.json \
        ${D}${datadir}/mctp/mctp_config.json
}
