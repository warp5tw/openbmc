SRC_URI_remove_buv-runbmc = "git://github.com/openbmc/phosphor-host-ipmid"
SRC_URI_prepend_buv-runbmc = "git://github.com/Nuvoton-Israel/phosphor-host-ipmid"

SRCREV := "0dd10bb5e4221916d55beb455435138f8dbb9a24"

DEPENDS_append_buv-runbmc = " buv-runbmc-yaml-config"

EXTRA_OECONF_buv-runbmc = " \
    --with-journal-sel \
    SENSOR_YAML_GEN=${STAGING_DIR_HOST}${datadir}/buv-runbmc-yaml-config/ipmi-sensors.yaml \
    FRU_YAML_GEN=${STAGING_DIR_HOST}${datadir}/buv-runbmc-yaml-config/ipmi-fru-read.yaml \
    "

do_install_append_buv-runbmc(){
  install -d ${D}${includedir}/phosphor-ipmi-host
  install -m 0644 -D ${S}/sensorhandler.hpp ${D}${includedir}/phosphor-ipmi-host
  install -m 0644 -D ${S}/selutility.hpp ${D}${includedir}/phosphor-ipmi-host
}
