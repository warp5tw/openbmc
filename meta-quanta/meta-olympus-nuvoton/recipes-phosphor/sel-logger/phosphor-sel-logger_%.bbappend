FILESEXTRAPATHS_append_olympus-nuvoton := "${THISDIR}/${PN}:"

# SRC_URI_append_olympus-nuvoton = " file://0001-add-sensor-evnet-log-support.patch"

# Enable threshold monitoring
EXTRA_OECMAKE += "-DSEL_LOGGER_MONITOR_THRESHOLD_EVENTS=ON"
