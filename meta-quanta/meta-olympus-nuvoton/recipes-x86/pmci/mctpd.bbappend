FILESEXTRAPATHS_prepend_olympus-nuvoton := "${THISDIR}/${PN}:"

SMBUS_BINDING = "pcie"

SRC_URI_olympus-nuvoton = "git://github.com/Nuvoton-Israel/pmci.git;protocol=ssh"

SRCREV_olympus-nuvoton = "6fe3d2677320c391aed5c6d61af38ed43b508e62"

SRC_URI_append_olympus-nuvoton = " file://mctp_config.json"

do_install_append_olympus-nuvoton() {
    install -m 0644 -D ${WORKDIR}/mctp_config.json \
        ${D}${datadir}/mctp/mctp_config.json
}
