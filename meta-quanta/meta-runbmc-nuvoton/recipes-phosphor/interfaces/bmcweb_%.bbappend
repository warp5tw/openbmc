FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_runbmc-nuvoton = " file://0002-bmcweb-increase-httpreqbody-to-35MB.patch"
SRC_URI_append_runbmc-nuvoton = " file://0003-Redfish-Add-power-metrics-support.patch"
SRC_URI_append_runbmc-nuvoton = " file://0001-Add-Redfish-property-PowerSupply-EfficiencyPercent.patch"
SRC_URI_append_runbmc-nuvoton = " file://0004-bmcweb-sensors-get-sensor-list-also-form-path-with-s.patch"

# Enable CPU Log and Raw PECI support
EXTRA_OECMAKE += "-DBMCWEB_ENABLE_REDFISH_CPU_LOG=ON"
EXTRA_OECMAKE += "-DBMCWEB_ENABLE_REDFISH_RAW_PECI=ON"

# Enable Redfish BMC Journal support
EXTRA_OECMAKE += "-DBMCWEB_ENABLE_REDFISH_BMC_JOURNAL=ON"

# Enable DBUS log service
# EXTRA_OECMAKE += "-DBMCWEB_ENABLE_REDFISH_DBUS_LOG_ENTRIES=ON"

# Enable TFTP
EXTRA_OECMAKE += "-DBMCWEB_INSECURE_ENABLE_REDFISH_FW_TFTP_UPDATE=ON"
