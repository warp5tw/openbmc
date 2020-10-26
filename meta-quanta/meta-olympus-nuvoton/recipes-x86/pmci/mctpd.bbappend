FILESEXTRAPATHS_prepend_olympus-nuvoton := "${THISDIR}/${PN}:"

SMBUS_BINDING = "pcie"

SRC_URI_olympus-nuvoton = "git://github.com/Nuvoton-Israel/pmci.git;protocol=ssh"
SRCREV_olympus-nuvoton = "d5cb01469d85f6cd8536f43140e321f8a565addc"

SRC_URI_append_olympus-nuvoton = " file://mctp_config.json"

do_install_append_olympus-nuvoton() {
    install -m 0644 -D ${WORKDIR}/mctp_config.json \
        ${D}${datadir}/mctp/mctp_config.json
}
