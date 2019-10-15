SUMMARY = "YAML configuration for Runbmc Nuvoton"
PR = "r1"
LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://${COREBASE}/meta/files/common-licenses/Apache-2.0;md5=89aea4e17d99a7cacdbeed46a0096b10"

inherit allarch

SRC_URI = " \
    file://runbmc-nuvoton-ipmi-fru.yaml \
    file://runbmc-nuvoton-ipmi-fru-bmc.yaml \
    file://runbmc-nuvoton-ipmi-fru-properties.yaml \
    file://runbmc-nuvoton-ipmi-inventory-sensors.yaml \
    file://runbmc-nuvoton-ipmi-sensors.yaml \
    file://runbmc-nuvoton-dbus-monitor-config.yaml \
    "

S = "${WORKDIR}"

do_install() {
    cat runbmc-nuvoton-ipmi-fru.yaml runbmc-nuvoton-ipmi-fru-bmc.yaml > fru-read.yaml

    install -m 0644 -D runbmc-nuvoton-ipmi-fru-properties.yaml \
        ${D}${datadir}/${BPN}/ipmi-extra-properties.yaml
    install -m 0644 -D fru-read.yaml \
        ${D}${datadir}/${BPN}/ipmi-fru-read.yaml
    install -m 0644 -D runbmc-nuvoton-ipmi-inventory-sensors.yaml \
        ${D}${datadir}/${BPN}/ipmi-inventory-sensors.yaml
    install -m 0644 -D runbmc-nuvoton-ipmi-sensors.yaml \
        ${D}${datadir}/${BPN}/ipmi-sensors.yaml
    install -m 0644 -D runbmc-nuvoton-dbus-monitor-config.yaml \
        ${D}${datadir}/phosphor-dbus-monitor/dbus-monitor-config.yaml
}

FILES_${PN}-dev = " \
    ${datadir}/${BPN}/ipmi-extra-properties.yaml \
    ${datadir}/${BPN}/ipmi-fru-read.yaml \
    ${datadir}/${BPN}/ipmi-inventory-sensors.yaml \
    ${datadir}/${BPN}/ipmi-sensors.yaml \
    ${datadir}/phosphor-dbus-monitor/dbus-monitor-config.yaml \
    "

ALLOW_EMPTY_${PN} = "1"
