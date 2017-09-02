FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

KBRANCH = "nuvoton/drivers/base"
SRCREV = "b08eb42a4b5b768f809f8f5a049dfad1833c47b0"

# TODO: replace with git://github.com/Nuvoton-Israel/linux.git when changes get
# pulled in.
KSRC = "git://github.com/bjh83/linux.git;branch=${KBRANCH}"
SRC_URI += "file://defconfig"

LINUX_VERSION = "4.13-rc4"
LINUX_VERSION_EXTENSION = "-nuvoton"
