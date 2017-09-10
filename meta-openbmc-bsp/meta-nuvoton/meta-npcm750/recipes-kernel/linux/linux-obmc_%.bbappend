FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

KBRANCH = "Poleg-4.10.15-OpenBMC"
SRCREV = "1969e5370f64ee256424d1fb8546fda082216ce1"

KSRC = "git://github.com/Nuvoton-Israel/linux;protocol=git;branch=${KBRANCH};"
SRC_URI += "file://defconfig"

LINUX_VERSION = "4.10.15"
LINUX_VERSION_EXTENSION = "-nuvoton"
