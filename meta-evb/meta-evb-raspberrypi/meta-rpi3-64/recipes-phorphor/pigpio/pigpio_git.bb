DESCRIPTION = "pigpio "
SECTION = "devtools"
LICENSE = "CLOSED"
LIC_FILES_CHKSUM = ""

SRC_URI = "git://github.com/joan2937/pigpio.git;protocol=https"

PV = "1.0+git${SRCPV}"
SRCREV = "db1fd9cf6c3431314b04edc486d900151a0dfd78"

S = "${WORKDIR}/git"

DEPENDS = "curl glib-2.0 openssl attr gpgme libxml2"

inherit pkgconfig cmake

FILES_${PN}_append = "${bindir}/pigpiod \
                      ${libdir}/libpigpio.so \
                     "
FILES_${PN}-dev = "${includedir}"

do_install() {
    install -d ${D}${bindir}
    install -d ${D}${libdir}
    install -m 0755 pigpiod ${D}${bindir}
    install -m 0755 libpigpio.so ${D}${libdir}
}
