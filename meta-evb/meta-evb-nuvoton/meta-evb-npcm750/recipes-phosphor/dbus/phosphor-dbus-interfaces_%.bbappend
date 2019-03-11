FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-sensor-add-property.patch"
SRC_URI += "file://0001-Set-Watchdog-ExpireAction-as-None.patch"
