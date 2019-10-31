FILESEXTRAPATHS_append := "${THISDIR}/${PN}:"

SRC_URI_append = " file://0001-add-sensor-evnet-log-support.patch"

# Enable threshold monitoring
EXTRA_OECMAKE += "-DSEL_LOGGER_MONITOR_THRESHOLD_EVENTS=ON"
