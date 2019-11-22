SRC_URI = "git://github.com/Nuvoton-Israel/phosphor-bmc-code-mgmt.git"
SRCREV = "57566c31115254000f7052dfbb93ab2e1914f82b"

FILESEXTRAPATHS_prepend_olympus-nuvoton := "${THISDIR}/${PN}:"

SRC_URI_append_olympus-nuvoton = " file://force-reboot.service"

inherit obmc-phosphor-systemd
SYSTEMD_SERVICE_${PN}-updater += "force-reboot.service"

FILES_${PN}-updater += "${datadir}/phosphor-bmc-code-mgmt/bios-release"

PACKAGECONFIG += "verify_signature"
