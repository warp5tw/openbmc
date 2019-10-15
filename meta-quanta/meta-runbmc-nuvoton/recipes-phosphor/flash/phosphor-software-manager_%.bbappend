SRC_URI = "git://github.com/Nuvoton-Israel/phosphor-bmc-code-mgmt.git"
SRCREV = "c84c94c5c0852844e14d60935af3a4ea1f64d159"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://force-reboot.service"

inherit obmc-phosphor-systemd
SYSTEMD_SERVICE_${PN}-updater += "force-reboot.service"

FILES_${PN}-updater += "${datadir}/phosphor-bmc-code-mgmt/bios-release"

PACKAGECONFIG += "verify_signature"
