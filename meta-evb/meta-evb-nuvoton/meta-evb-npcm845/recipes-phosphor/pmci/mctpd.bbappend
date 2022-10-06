FILESEXTRAPATHS:prepend:evb-npcm845 := "${THISDIR}/${PN}:"

SMBUS_BINDING = "pcie"

SRC_URI:evb-npcm845 = "git://github.com/warp5tw/mctpd.git;protocol=https;branch=main"

SRCREV:evb-npcm845 = "91c7524bded8d8e2c39f75ded0762b88e3baa86c"

SRC_URI:append:evb-npcm845 = " file://mctp_config.json"
SRC_URI:append:evb-npcm845 = " file://xyz.openbmc_project.mctpd@.service"

SYSTEMD_SERVICE:${PN}:append:evb-npcm845 := "xyz.openbmc_project.mctpd@${SMBUS_BINDING}.service"

do_install:append:evb-npcm845() {
	install -m 0644 -D ${WORKDIR}/mctp_config.json \
		${D}${datadir}/mctp/mctp_config.json

        install -m 0644 ${WORKDIR}/xyz.openbmc_project.mctpd@.service \
                ${D}${systemd_system_unitdir}
}
