SRC_URI_olympus-nuvoton := "git://github.com/quanta-bmc/phosphor-sel-logger.git"
SRCREV_olympus-nuvoton := "${AUTOREV}"

# Enable threshold monitoring
EXTRA_OECMAKE += "-DSEL_LOGGER_MONITOR_THRESHOLD_EVENTS=ON"
