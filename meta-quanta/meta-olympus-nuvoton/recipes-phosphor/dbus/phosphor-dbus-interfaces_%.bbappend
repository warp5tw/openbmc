FILESEXTRAPATHS_prepend_olympus-nuvoton := "${THISDIR}/${PN}:"

SRC_URI_append_olympus-nuvoton = " file://0001-Add-sensor-threshold-error-items.patch"
SRC_URI_append_olympus-nuvoton = " file://0001-set-watchdog-Interval-value-to-three-minutes.patch"
SRC_URI_append_olympus-nuvoton = " file://0001-add-error-WatchdogTimedOut-under-Control.Boot.patch"
SRC_URI_append_olympus-nuvoton = " file://0005-Add-DBUS-interface-of-CPU-and-Memory-s-properties.patch"
SRC_URI_append_olympus-nuvoton = " file://0001-support-type-uint8-uint16-uint32-for-inventory-manag.patch"
SRC_URI_append_olympus-nuvoton = " file://0001-Software-Add-MCU-VersionPurpose.patch"
SRC_URI_append_olympus-nuvoton = " file://0028-MCTP-Daemon-D-Bus-interface-definition.patch"
