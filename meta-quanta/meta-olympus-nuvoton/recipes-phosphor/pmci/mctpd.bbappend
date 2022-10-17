FILESEXTRAPATHS:prepend:olympus-nuvoton := "${THISDIR}/${PN}:"

SMBUS_BINDING = "pcie"

SRC_URI:olympus-nuvoton = "git://github.com/warp5tw/mctpd.git;protocol=https;branch=main"

SRCREV:olympus-nuvoton = "91c7524bded8d8e2c39f75ded0762b88e3baa86c"

SRC_URI:append:olympus-nuvoton = " file://mctp_config.json"
SRC_URI:append:olympus-nuvoton = " file://xyz.openbmc_project.mctpd@.service"

SYSTEMD_SERVICE:${PN}:append:olympus-nuvoton := "xyz.openbmc_project.mctpd@${SMBUS_BINDING}.service"

do_install:append:olympus-nuvoton() {
	install -m 0644 -D ${WORKDIR}/mctp_config.json \
		${D}${datadir}/mctp/mctp_config.json

        install -m 0644 ${WORKDIR}/xyz.openbmc_project.mctpd@.service \
                ${D}${systemd_system_unitdir}
}
