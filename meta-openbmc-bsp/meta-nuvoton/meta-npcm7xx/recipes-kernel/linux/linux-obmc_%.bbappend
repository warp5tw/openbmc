FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

KBRANCH = "Poleg-4.10.15-OpenBMC"
SRCREV = "5a741410f2a0641ecbc4e658bc9fad66e04cfedb"

KSRC = "git://github.com/Nuvoton-Israel/linux;protocol=git;branch=${KBRANCH};"
SRC_URI += "file://defconfig"

LINUX_VERSION = "4.10.15"
LINUX_VERSION_EXTENSION = "-nuvoton"
