FILESEXTRAPATHS_prepend_olympus-nuvoton := "${THISDIR}/${PN}:"

SRC_URI_olympus-nuvoton := "git://github.com/Nuvoton-Israel/libmctp.git"
SRCREV_olympus-nuvoton := "e7da99ddb174bce0c54948afbffae5d9f3f36ab9"

TARGET_CFLAGS += "-DMCTP_HAVE_FILEIO"


