RMCPP_IFACE = "eth1"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI_append_olympus-nuvoton = " file://0001-Add-dbus-interface-for-sol-commands.patch"
SRC_URI_append_olympus-nuvoton = " file://0002-Remove-Get-SOL-Config-Command-from-Netipmid.patch"

SRCREV := "9edc2314f7dea855e82bc0a64f2e3d9de2bf7431"
