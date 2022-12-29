FILESEXTRAPATHS_prepend_olympus-nuvoton := "${THISDIR}/${PN}:"

#SRC_URI_olympus-nuvoton := "git://github.com/Nuvoton-Israel/libmctp.git"
#SRCREV_olympus-nuvoton := "09a11109c694b3c690370f640e84983ae6e2db7e"
SRC_URI_olympus-nuvoton := "git://github.com/warp5tw/libmctp.git;branch=update_8_31"
SRCREV_olympus-nuvoton := "ad75f8aeb2cf07be9ca6a089491e650bae1f80f3"

TARGET_CFLAGS += "-DMCTP_HAVE_FILEIO"


