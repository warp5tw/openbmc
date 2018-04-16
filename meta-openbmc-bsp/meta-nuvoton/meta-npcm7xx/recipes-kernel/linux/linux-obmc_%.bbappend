FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

KBRANCH = "Poleg-4.13.05-OpenBMC"
SRCREV = "c3f76e86c72007142bca5b965bb00b205f495330"

KSRC = "git://github.com/Nuvoton-Israel/linux;protocol=git;branch=${KBRANCH};"
SRC_URI += "file://defconfig"

LINUX_VERSION = "4.13.5"
LINUX_VERSION_EXTENSION = "-nuvoton"
