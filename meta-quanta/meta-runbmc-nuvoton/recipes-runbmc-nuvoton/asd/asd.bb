DESCRIPTION = "Intel at-scale-debug"

SRC_URI = "git://github.com/Intel-BMC/asd.git"
SRCREV = "bcc326ea6968ac002bb10b5bc848368d957ba049"
PV = "0.1+git${SRCPV}"

LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=0d1c657b2ba1e8877940a8d1614ec560"

DEPENDS = "sdbusplus \
           libgpiod"

SRC_URI += " \
           file://0001-gpio.patch \
           "

S = "${WORKDIR}/git/"
inherit cmake

EXTRA_OECMAKE = "-DBUILD_UT=OFF"

