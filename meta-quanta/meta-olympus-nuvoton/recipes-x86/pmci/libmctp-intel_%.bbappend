FILESEXTRAPATHS_prepend_olympus-nuvoton := "${THISDIR}/${PN}:"

SRC_URI_olympus-nuvoton := "git://github.com/Nuvoton-Israel/libmctp.git"
SRCREV_olympus-nuvoton := "0fb521340c788953fe97fbaacf0deb788685f27f"

TARGET_CFLAGS += "-DMCTP_HAVE_FILEIO"


