FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

KBRANCH = "Poleg-4.10.15-OpenBMC"
SRCREV = "37e95bd7a5ed6e421c6f760b1371a1f6ca249b71"

KSRC = "git://github.com/Nuvoton-Israel/linux;protocol=git;branch=${KBRANCH};"
SRC_URI += "file://defconfig"

LINUX_VERSION = "4.10.15"
LINUX_VERSION_EXTENSION = "-nuvoton"
