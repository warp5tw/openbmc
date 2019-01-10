FILESEXTRAPATHS_prepend := "${THISDIR}/linux-nuvoton:"

KBRANCH = "Poleg-4.13.05-OpenBMC"
LINUX_VERSION = "4.13.5"

KSRC = "git://github.com/Nuvoton-Israel/linux;protocol=git;branch=${KBRANCH}"
SRCREV = "396c80f91f7f123f040dbe8fb4679201c2ce4d9f"

SRC_URI += "file://defconfig "
SRC_URI += "file://0001-hwmon_change.patch"
SRC_URI += "file://enable-vcd-ece.cfg"
SRC_URI += "file://enable-configfs-hid.cfg"
SRC_URI += "file://enable-led.cfg"
SRC_URI += "file://0002-nbd-fix-reconnect.patch"
SRC_URI += "file://enable-configfs-mstg.cfg"
SRC_URI += "file://0001-dts-jtag-npcm-add-gpios-for-jtag_drv.patch"
SRC_URI += "file://0001-FAN-Fix-RPM-convert-formula-from-fan-count.patch"
SRC_URI += "file://0001-modify-mtd-partion.patch"

LINUX_VERSION_EXTENSION = "-${SRCREV}"
PV = "${LINUX_VERSION}+git${SRCPV}"

LINUX_VERSION_EXTENSION = "-nuvoton"
LIC_FILES_CHKSUM = "file://COPYING;md5=d7810fab7487fb0aad327b76f1be7cd7"
