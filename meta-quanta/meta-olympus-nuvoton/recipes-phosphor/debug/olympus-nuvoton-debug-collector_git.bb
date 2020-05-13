SUMMARY = "Olympus Nuvoton Debug Collector"
DESCRIPTION = "Application to log error during host checkstop and watchdog timeout"

PR = "r1"
PV = "1.0+git${SRCPV}"

inherit autotools \
        pkgconfig \
        obmc-phosphor-systemd \
        phosphor-dbus-yaml

require ${PN}.inc

DEPENDS += " \
        phosphor-logging \
        autoconf-archive-native \
        sdbusplus-native \
        "
S = "${WORKDIR}/git"

# This provides below 2 applications that are called into in case
# of host checkstop and host watchdog timeout respectively.
APPS = "checkstop watchdog"

DEBUG_TMPL = "olympus-nuvoton-debug-collector-{0}@.service"
SYSTEMD_SERVICE_${PN} += "${@compose_list(d, 'DEBUG_TMPL', 'APPS')}"

# This needs to be executed as part of host crash
CHECKSTOP_TMPL = "olympus-nuvoton-debug-collector-checkstop@.service"
CRASH_TGTFMT = "obmc-host-crash@{0}.target"
CHECKSTOP_INSTFMT = "olympus-nuvoton-debug-collector-checkstop@{0}.service"
CRASH_CHECKSTOP_FMT = "../${CHECKSTOP_TMPL}:${CRASH_TGTFMT}.wants/${CHECKSTOP_INSTFMT}"

# Make watchdog part of obmc-host-timeout target
WDOG_TMPL = "olympus-nuvoton-debug-collector-watchdog@.service"
TIMEOUT_TGTFMT = "obmc-host-timeout@{0}.target"
WDOG_INSTFMT = "olympus-nuvoton-debug-collector-watchdog@{0}.service"
TIMEOUT_WDOG_FMT = "../${WDOG_TMPL}:${TIMEOUT_TGTFMT}.wants/${WDOG_INSTFMT}"

# Capture debug information on watchdog timeout
# DEBUG_WD_TIMEOUT_TMPL = "olympus-nuvoton-debug-collector-watchdog-timeout@.service"
# DEBUG_WD_TIMEOUT_INSTFMT = "olympus-nuvoton-debug-collector-watchdog-timeout@{0}.service"
# DEBUG_WD_TIMEOUT_FMT = "../${DEBUG_WD_TIMEOUT_TMPL}:${TIMEOUT_TGTFMT}.wants/${DEBUG_WD_TIMEOUT_INSTFMT}"

SYSTEMD_LINK_${PN} += "${@compose_list(d, 'CRASH_CHECKSTOP_FMT', 'OBMC_HOST_INSTANCES')}"
SYSTEMD_LINK_${PN} += "${@compose_list(d, 'TIMEOUT_WDOG_FMT', 'OBMC_HOST_INSTANCES')}"
# SYSTEMD_LINK_${PN} += "${@compose_list(d, 'DEBUG_WD_TIMEOUT_FMT', 'OBMC_HOST_INSTANCES')}"

# Do not depend on phosphor-logging for native build
DEPENDS_remove_class-native = "phosphor-logging"

# Do not depend on phosphor-logging for native SDK build
DEPENDS_remove_class-nativesdk = "phosphor-logging"

# Provide a means to enable/disable install_error_yaml feature
PACKAGECONFIG ??= "install_error_yaml"
PACKAGECONFIG[install_error_yaml] = " \
        --enable-install_error_yaml, \
        --disable-install_error_yaml, ,\
        "

# Enable install_error_yaml during native and native SDK build
PACKAGECONFIG_add_class-native = "install_error_yaml"
PACKAGECONFIG_add_class-nativesdk = "install_error_yaml"

# Disable install_error_yaml during target build
PACKAGECONFIG_remove_class-target = "install_error_yaml"

# Disable generating elog error header file during bitbake. Applications
# should be using the elog header generated by phosphor-logging recipe
EXTRA_OECONF += "--disable-gen_errors"

BBCLASSEXTEND += "native nativesdk"
