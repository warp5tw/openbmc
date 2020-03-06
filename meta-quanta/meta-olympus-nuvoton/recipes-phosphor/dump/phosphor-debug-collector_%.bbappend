FILESEXTRAPATHS_prepend_olympus-nuvoton := "${THISDIR}/${PN}:"

SRC_URI_append_olympus-nuvoton = " file://0001-phosphor-dump-manager-fix-SEGV-exception.patch"

EXTRA_OECONF += "BMC_DUMP_TOTAL_SIZE=500 "
