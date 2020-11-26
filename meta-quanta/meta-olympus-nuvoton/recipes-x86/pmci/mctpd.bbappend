FILESEXTRAPATHS_prepend_olympus-nuvoton := "${THISDIR}/${PN}:"

SMBUS_BINDING = "pcie"

SRC_URI_olympus-nuvoton = "git://github.com/Nuvoton-Israel/pmci.git;protocol=ssh"

SRCREV_olympus-nuvoton = "e121745a6c311576b341e0481d8d37b8989cea0f"

SRC_URI_append_olympus-nuvoton = " file://mctp_config.json"

do_install_append_olympus-nuvoton() {
    install -m 0644 -D ${WORKDIR}/mctp_config.json \
        ${D}${datadir}/mctp/mctp_config.json
}
