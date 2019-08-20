inherit obmc-phosphor-systemd

FILESEXTRAPATHS_prepend_runbmc-nuvoton := "${THISDIR}/${PN}:"

DEPENDS_append_romulus = " runbmc-nuvoton-yaml-config"

EXTRA_OECONF_runbmc-nuvoton = " \
    YAML_GEN=${STAGING_DIR_HOST}${datadir}/runbmc-nuvoton-yaml-config/ipmi-fru-read.yaml \
    PROP_YAML=${STAGING_DIR_HOST}${datadir}/runbmc-nuvoton-yaml-config/ipmi-extra-properties.yaml \
    "

EEPROM_NAMES = "motherboard bmc"

EEPROMFMT = "system/chassis/{0}"
EEPROM_ESCAPEDFMT = "system-chassis-{0}"
EEPROMS = "${@compose_list(d, 'EEPROMFMT', 'EEPROM_NAMES')}"
EEPROMS_ESCAPED = "${@compose_list(d, 'EEPROM_ESCAPEDFMT', 'EEPROM_NAMES')}"

ENVFMT = "obmc/eeproms/{0}"
SYSTEMD_ENVIRONMENT_FILE_${PN}_append_runbmc-nuvoton := " ${@compose_list(d, 'ENVFMT', 'EEPROMS')}"

TMPL = "obmc-read-eeprom@.service"
TGT = "${SYSTEMD_DEFAULT_TARGET}"
INSTFMT = "obmc-read-eeprom@{0}.service"
FMT = "../${TMPL}:${TGT}.wants/${INSTFMT}"

SYSTEMD_LINK_${PN}_append_runbmc-nuvoton := " ${@compose_list(d, 'FMT', 'EEPROMS_ESCAPED')}"
