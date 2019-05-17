FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

DEPENDS += "bison-native"

LIC_FILES_CHKSUM = "file://Licenses/README;md5=30503fd321432fc713238f582193b78e"

UBRANCH = "npcm7xx-v2019.01"
SRC_URI = "git://github.com/Nuvoton-Israel/u-boot.git;branch=${UBRANCH}"
SRCREV = "8a75ce57dfd476bfc2df093384d187a4737b4881"
