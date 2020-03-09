SUMMARY = "Power supply manager for Intel based platform"
DESCRIPTION = "Power supply manager which include PSU Cold Redundancy service"

SRC_URI = "git://github.com/Intel-BMC/provingground.git;protocol=ssh"
SRCREV = "bee56d62b209088454d166d1efae4825a2b175df"

FILESEXTRAPATHS_prepend_olympus-nuvoton := "${THISDIR}/files:"

SRC_URI_append_olympus-nuvoton = " file://xyz.openbmc_project.coldredundancy.service"
SRC_URI_append_olympus-nuvoton = " file://0001-psu-manager-support-Olympus-platform.patch"

S = "${WORKDIR}/git/psu-manager/"

PV = "1.0+git${SRCPV}"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${S}/LICENSE;md5=e3fc50a88d0a364313df4b21ef20c29e"

inherit cmake
inherit systemd
inherit obmc-phosphor-dbus-service

SYSTEMD_SERVICE_${PN} += "xyz.openbmc_project.coldredundancy.service"
DBUS_SERVICE_${PN} = "xyz.openbmc_project.coldredundancy.service"

DEPENDS += " \
    systemd \
    sdbusplus \
    phosphor-dbus-interfaces \
    phosphor-logging \
    boost \
    i2c-tools \
    "

do_install_prepend_olympus-nuvoton() {
    install -m 644 ${WORKDIR}/xyz.openbmc_project.coldredundancy.service ${S}/service_files/xyz.openbmc_project.coldredundancy.service
}

do_install_append_olympus-nuvoton() {
    install -m 644 ${WORKDIR}/xyz.openbmc_project.coldredundancy.service ${D}${systemd_system_unitdir}/
}

