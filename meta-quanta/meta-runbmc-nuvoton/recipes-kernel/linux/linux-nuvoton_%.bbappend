KBRANCH = "Poleg-4.19.16-OpenBMC"
LINUX_VERSION = "4.19.16"

KSRC = "git://github.com/Nuvoton-Israel/linux;protocol=git;branch=${KBRANCH}"
SRCREV = "4b91716eec419a4a5f065ea06c8b16ec2acf019a"

FILESEXTRAPATHS_prepend := "${THISDIR}/linux-nuvoton:"

SRC_URI += "file://runbmc-nuvoton.cfg"
SRC_URI += "file://0001-Revert-mtd-spi-nor-fix-options-for-mx66l51235f.patch"
SRC_URI += "file://0001-add-tps53622-and-tps53659.patch"
SRC_URI += "file://runbmc-nuvoton-enable-slave-mqueue.cfg"
SRC_URI += "file://0001-media-platform-npcm750-vcd-driver-0.0.7.patch"
SRC_URI += "file://0001-i2c-driver-v27-test.patch"
