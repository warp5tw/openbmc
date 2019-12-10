SRC_URI = "git://github.com/Nuvoton-Israel/phosphor-bmc-code-mgmt.git"
SRCREV = "cd0c833e1273e12805443cefaf8c9401cc1b9c17"

FILESEXTRAPATHS_prepend_olympus-nuvoton := "${THISDIR}/${PN}:"

inherit obmc-phosphor-systemd
SYSTEMD_SERVICE_${PN}-updater_append_olympus-nuvoton = " \
    force-reboot.service \
    reboot-guard-enable.service \
    reboot-guard-disable.service \
"

FILES_${PN}-updater_append_olympus-nuvoton = " \
    ${datadir}/phosphor-bmc-code-mgmt/bios-release"

PACKAGECONFIG += "verify_signature"
