FILESEXTRAPATHS:prepend:olympus-nuvoton := "${THISDIR}/${PN}:"

SRC_URI:olympus-nuvoton := "git://github.com/warp5tw/libmctp.git;protocol=https;branch=master"
SRCREV:olympus-nuvoton := "c0cdb105e005a45716f9e481d82a16f9f8c9bcf2"

TARGET_CFLAGS += "-DMCTP_HAVE_FILEIO"
TARGET_CFLAGS += "-DMCTP_DEFAULT_ALLOC"
