FILESEXTRAPATHS:prepend:evb-npcm845 := "${THISDIR}/${PN}:"

SRC_URI:append:evb-npcm845 = " file://0001-update-NMISource-interface-from-intel-dbus-interface.patch"
SRC_URI:append:evb-npcm845 = " file://0028-MCTP-Daemon-D-Bus-interface-definition.patch"
SRC_URI:append:evb-npcm845 = " file://0032-update-meson-build-for-MCTP-interfaces.patch"
