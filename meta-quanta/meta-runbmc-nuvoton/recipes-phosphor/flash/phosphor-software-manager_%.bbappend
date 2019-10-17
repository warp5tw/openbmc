FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-updater-Add-initial-bios-version-support.patch"
SRC_URI += "file://0002-support_bios_update.patch"
SRC_URI += "file://0003-activation-add-applyTime-support-for-no-ubi-layout-c.patch"
SRC_URI += "file://force-reboot.service"

inherit obmc-phosphor-systemd
SYSTEMD_SERVICE_${PN}-updater += "force-reboot.service"

FILES_${PN}-updater += "${datadir}/phosphor-bmc-code-mgmt/bios-release"

PACKAGECONFIG += "verify_signature"
