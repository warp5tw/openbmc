echo "reload sensor config $1"

CONF_DIR=/etc/default/obmc/hwmon/ahb/apb/

if [ $1 = "1" ]; then
    systemctl stop xyz.openbmc_project.Logging.IPMI.service
    if [ -f $CONF_DIR/adc@c000.conf ]; then
        systemctl stop "xyz.openbmc_project.Hwmon_hostoff@-ahb-apb-adc\x40c000.service"
    fi
    sleep 1
    if [ -f $CONF_DIR/adc@c000.conf ]; then
        systemctl start "xyz.openbmc_project.Hwmon@-ahb-apb-adc\x40c000.service"
    fi
    systemctl start "xyz.openbmc_project.Hwmon@-ahb-apb-pwm\x2dfan\x2dcontroller\x40103000.service"
    echo -n "f0086000.i2c" > /sys/bus/platform/drivers/nuvoton-i2c/bind
    sleep 15
    systemctl start xyz.openbmc_project.Logging.IPMI.service
else
    if [ $1 = "boot_check" ]; then
        if [ -f "/run/openbmc/chassis@0-on" ]; then
            exit 0
        fi
    fi
    if [ $1 = "0" ]; then
        systemctl stop xyz.openbmc_project.Logging.IPMI.service
    fi
    systemctl stop "xyz.openbmc_project.Hwmon@-ahb-apb-pwm\x2dfan\x2dcontroller\x40103000.service"
    if [ -f $CONF_DIR/adc@c000.conf ]; then
        systemctl stop "xyz.openbmc_project.Hwmon@-ahb-apb-adc\x40c000.service"
    fi
    sleep 1
    if [ -f $CONF_DIR/adc@c000.conf ]; then
        systemctl start "xyz.openbmc_project.Hwmon_hostoff@-ahb-apb-adc\x40c000.service"
    fi
    if [ -d "/sys/bus/platform/drivers/nuvoton-i2c/f0086000.i2c" ]; then
        echo -n "f0086000.i2c" > /sys/bus/platform/drivers/nuvoton-i2c/unbind
    fi
    sleep 15
    if [ $1 = "0" ]; then
        systemctl start xyz.openbmc_project.Logging.IPMI.service
    fi
fi
