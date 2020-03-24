FILESEXTRAPATHS_prepend := "${THISDIR}/linux-nuvoton:"

KBRANCH = "Poleg-4.19.16-OpenBMC"
LINUX_VERSION = "4.19.16"

KSRC = "git://github.com/Nuvoton-Israel/linux;protocol=git;branch=${KBRANCH}"
SRCREV = "37fb9b406fa2af29b5a24f200ce57d1d6c2f61bb"

SRC_URI += "file://evb-npcm750.cfg"
SRC_URI += "file://enable-vcd-ece.cfg"
SRC_URI += "file://enable-configfs-hid.cfg"
SRC_URI += "file://001-partitions.patch"
SRC_URI += "file://enable-configfs-mstg.cfg"
SRC_URI += "file://0002-nbd-fix-reconnect.patch"
SRC_URI += "file://0001-Revert-mtd-spi-nor-fix-options-for-mx66l51235f.patch"
SRC_URI += "file://enable-slave-mqueue.cfg"
SRC_URI += "file://0001-fru-modify-dts-for-eeprom.patch"
