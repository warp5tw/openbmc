HOMEPAGE = "https://github.com/Nuvoton-Israel/u-boot"
SECTION = "bootloaders"
DEPENDS += "flex-native bison-native"

LICENSE = "GPLv2+"
LIC_FILES_CHKSUM = "file://Licenses/README;md5=30503fd321432fc713238f582193b78e"

UBRANCH = "npcm7xx-v2019.01"
SRC_URI = "git://github.com/Nuvoton-Israel/u-boot.git;branch=${UBRANCH}"
SRCREV = "b823f4c8cc8d095b89cd914f410eead4bd3e194d"

S = "${WORKDIR}/git"

PV .= "+${UBRANCH}+"
