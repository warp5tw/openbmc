SRC_URI = "git://github.com/Nuvoton-Israel/phosphor-bmc-code-mgmt.git"
SRCREV = "22241b8bfd0a39ee9b18dafb23091eeb40f4b6d6"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://force-reboot.service"

inherit obmc-phosphor-systemd
SYSTEMD_SERVICE_${PN}-updater += "force-reboot.service"

FILES_${PN}-updater += "${datadir}/phosphor-bmc-code-mgmt/bios-release"

PACKAGECONFIG += "verify_signature"
