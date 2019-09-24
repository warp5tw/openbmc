SUMMARY = "Phosphor OpenBMC IPMI SEL Logger"
DESCRIPTION = "Phosphor OpenBMC IPMI SEL Logger."
PR = "r1"

inherit cmake systemd

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

DEPENDS += "systemd sdbusplus boost phosphor-logging"

SYSTEMD_SERVICE_${PN} += "xyz.openbmc_project.Logging.IPMI.service"

DEPENDS += " \
        autoconf-archive-native \
        systemd \
        sdbusplus \
        "
DEPENDS += "phosphor-logging"

RDEPENDS_${PN} += " \
        libsystemd \
        "
RDEPENDS_${PN}-dev += "phosphor-logging"

S = "${WORKDIR}"
SRC_URI += " \
        file://bootstrap.sh \
        file://configure.ac \
        file://sel_logger.cpp \
        file://CMakeLists.txt \
        file://cmake-format.json \
        file://README.md \
        file://xyz.openbmc_project.Logging.IPMI.service \
        "


