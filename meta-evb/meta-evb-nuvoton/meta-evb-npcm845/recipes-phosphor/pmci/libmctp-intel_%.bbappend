FILESEXTRAPATHS:prepend:evb-npcm845 := "${THISDIR}/${PN}:"

SRC_URI:evb-npcm845 := "git://github.com/warp5tw/libmctp.git"
SRCREV:evb-npcm845 := "c0cdb105e005a45716f9e481d82a16f9f8c9bcf2"

TARGET_CFLAGS += "-DMCTP_HAVE_FILEIO"
TARGET_CFLAGS += "-DMCTP_DEFAULT_ALLOC"
