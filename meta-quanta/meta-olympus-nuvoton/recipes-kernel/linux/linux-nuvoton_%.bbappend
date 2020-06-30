FILESEXTRAPATHS_prepend := "${THISDIR}/linux-nuvoton:"

SRC_URI_append_olympus-nuvoton = " file://0001-Modify-Olympus-flash-size-from-32MB-to-64MB.patch"
SRC_URI_append_olympus-nuvoton = " file://perf-fix-build-with-binutils.patch"
SRC_URI_append_olympus-nuvoton = " file://olympus-nuvoton.cfg"
SRC_URI_append_olympus-nuvoton = " file://vlan.cfg"
SRC_URI_append_olympus-nuvoton = " file://perf.cfg"
