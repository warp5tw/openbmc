FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

DEPENDS += "bison-native"

LIC_FILES_CHKSUM = "file://Licenses/README;md5=30503fd321432fc713238f582193b78e"

UBRANCH = "npcm7xx-v2019.01"
SRC_URI = "git://github.com/Nuvoton-Israel/u-boot.git;branch=${UBRANCH}"
SRCREV = "835c8f88e7c42a5b0b16c042f37266328b15813d"
