SRC_URI = "git://github.com/Nuvoton-Israel/phosphor-bmc-code-mgmt.git"
SRCREV = "11809ee9792409ec59252f16f52b3ca67e3c3b1f"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://force-reboot.service"

inherit obmc-phosphor-systemd
SYSTEMD_SERVICE_${PN}-updater += "force-reboot.service"

FILES_${PN}-updater += "${datadir}/phosphor-bmc-code-mgmt/bios-release"

PACKAGECONFIG += "verify_signature"
