SRC_URI = "git://github.com/Nuvoton-Israel/dbus-sensors.git"
SRCREV = "${AUTOREV}"

SYSTEMD_SERVICE_${PN}_remove += " \
    xyz.openbmc_project.adcsensor.service \
    xyz.openbmc_project.fansensor.service \
    xyz.openbmc_project.hwmontempsensor.service \
    xyz.openbmc_project.intrusionsensor.service \
    xyz.openbmc_project.ipmbsensor.service \
    xyz.openbmc_project.mcutempsensor.service \
    xyz.openbmc_project.psusensor.service \
    xyz.openbmc_project.exitairsensor.service \
    "

do_install_append(){
    rm -f ${D}/${bindir}/adcsensor
	rm -f ${D}/${bindir}/exitairtempsensor
	rm -f ${D}/${bindir}/fansensor
	rm -f ${D}/${bindir}/hwmontempsensor
	rm -f ${D}/${bindir}/intrusionsensor
	rm -f ${D}/${bindir}/ipmbsensor
	rm -f ${D}/${bindir}/mcutempsensor
	rm -f ${D}/${bindir}/psusensor
	rm -f ${D}/${systemd_unitdir}/system/xyz.openbmc_project.adcsensor.service
	rm -f ${D}/${systemd_unitdir}/system/xyz.openbmc_project.exitairsensor.service
	rm -f ${D}/${systemd_unitdir}/system/xyz.openbmc_project.fansensor.service
	rm -f ${D}/${systemd_unitdir}/system/xyz.openbmc_project.hwmontempsensor.service
	rm -f ${D}/${systemd_unitdir}/system/xyz.openbmc_project.intrusionsensor.service
	rm -f ${D}/${systemd_unitdir}/system/xyz.openbmc_project.ipmbsensor.service
	rm -f ${D}/${systemd_unitdir}/system/xyz.openbmc_project.mcutempsensor.service
	rm -f ${D}/${systemd_unitdir}/system/xyz.openbmc_project.psusensor.service
}

