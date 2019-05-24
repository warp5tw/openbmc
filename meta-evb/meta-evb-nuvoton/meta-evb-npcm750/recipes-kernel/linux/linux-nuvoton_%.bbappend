FILESEXTRAPATHS_prepend := "${THISDIR}/linux-nuvoton:"

KBRANCH = "Poleg-4.19.16-OpenBMC"
LINUX_VERSION = "4.19.16"

KSRC = "git://github.com/Nuvoton-Israel/linux;protocol=git;branch=${KBRANCH}"
SRCREV = "8a1265d8adb5e6df1dc0092000325193c8bdeaab"

SRC_URI += "file://evb-npcm750.cfg"
SRC_URI += "file://enable-vcd-ece.cfg"
SRC_URI += "file://enable-configfs-hid.cfg"
SRC_URI += "file://001-partitions.patch"
SRC_URI += "file://enable-configfs-mstg.cfg"
SRC_URI += "file://0002-nbd-fix-reconnect.patch"
SRC_URI += "file://0001-Revert-mtd-spi-nor-fix-options-for-mx66l51235f.patch"
SRC_URI += "file://enable-slave-mqueue.cfg"
SRC_URI += "file://0001-Enable-the-i2c-slave-mqueue-driver-by-Intel.patch"
SRC_URI += "file://0001-fru-modify-dts-for-eeprom.patch"
