SUMMARY = "Nuvoton IPMI OEM commands"
DESCRIPTION = "Nuvoton IPMI OEM commands"
HOMEPAGE = "https://github.com/openbmc/"
PR = "r1"
PV = "0.1+git${SRCPV}"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=ce3556061e8d4b01638d497053a82dfd"

inherit autotools pkgconfig
inherit systemd
inherit obmc-phosphor-ipmiprovider-symlink

DEPENDS += "autoconf-archive-native"
DEPENDS += "sdbusplus"
DEPENDS += "phosphor-logging"
DEPENDS += "phosphor-ipmi-host"
DEPENDS += "nlohmann-json"

S = "${WORKDIR}/git"
SRC_URI = "git:///home/kfting/work/openbmc/github/ntil/libipmioem;protocol=file;branch=master"
SRCREV = "${AUTOREV}"

FILES_${PN}_append = " ${libdir}/ipmid-providers/lib*${SOLIBS}"
FILES_${PN}_append = " ${libdir}/host-ipmid/lib*${SOLIBS}"
FILES_${PN}_append = " ${libdir}/net-ipmid/lib*${SOLIBS}"
FILES_${PN}-dev_append = " ${libdir}/ipmid-providers/lib*${SOLIBSDEV} ${libdir}/ipmid-providers/*.la"

HOSTIPMI_PROVIDER_LIBRARY += "libnuvoemcmds.so"

SYSTEMD_PACKAGES = "${PN}"

