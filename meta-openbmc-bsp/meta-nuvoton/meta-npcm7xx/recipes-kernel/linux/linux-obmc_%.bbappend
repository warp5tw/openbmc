FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

KBRANCH = "Poleg-4.13.05-OpenBMC"
SRCREV = "faa916f92b9e9e2884e7596106ecf7e9b2cd5995"

KSRC = "git://github.com/Nuvoton-Israel/linux;protocol=git;branch=${KBRANCH};"
SRC_URI += "file://defconfig"

LINUX_VERSION = "4.13.5"
LINUX_VERSION_EXTENSION = "-nuvoton"
