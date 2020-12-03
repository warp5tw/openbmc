FILESEXTRAPATHS_prepend_olympus-nuvoton := "${THISDIR}/${PN}:"

SRC_URI_olympus-nuvoton := "git://github.com/Nuvoton-Israel/libmctp.git"
SRCREV_olympus-nuvoton := "eb6662dfbe6b1d2731941d2648f75e02ea39f777"

TARGET_CFLAGS += "-DMCTP_HAVE_FILEIO"


