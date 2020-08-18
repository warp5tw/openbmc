DEPENDS_append_buv-runbmc = " buv-runbmc-yaml-config"

EXTRA_OECONF_buv-runbmc = " \
    SENSOR_YAML_GEN=${STAGING_DIR_HOST}${datadir}/buv-runbmc-yaml-config/ipmi-sensors.yaml \
    FRU_YAML_GEN=${STAGING_DIR_HOST}${datadir}/buv-runbmc-yaml-config/ipmi-fru-read.yaml \
    "

do_install_append_buv-runbmc(){
  install -d ${D}${includedir}/phosphor-ipmi-host
  install -m 0644 -D ${S}/sensorhandler.hpp ${D}${includedir}/phosphor-ipmi-host
  install -m 0644 -D ${S}/selutility.hpp ${D}${includedir}/phosphor-ipmi-host
}
