FILESEXTRAPATHS_prepend_buv-runbmc := "${THISDIR}/${PN}:"

ITEMS = " \
        i2c@8b000/ina219@40 \
        i2c@8b000/ina219@41 \
        i2c@8c000/tmp75@48  \
        i2c@8d000/tmp75@4a  \
        pwm-fan-controller@103000 \
        adc@c000 \
        "

ENVS = "obmc/hwmon/ahb/apb/{0}.conf"
SYSTEMD_ENVIRONMENT_FILE_${PN}_append_buv-runbmc = " ${@compose_list(d, 'ENVS', 'ITEMS')}"
