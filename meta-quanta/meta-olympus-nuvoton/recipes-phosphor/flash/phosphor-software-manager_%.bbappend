SRC_URI = "git://github.com/Nuvoton-Israel/phosphor-bmc-code-mgmt.git"
SRCREV = "3bdf22dde6ea11bbcc797c9f9ed62776fcebbd79"

FILES_${PN}-updater_append_olympus-nuvoton = " \
    ${datadir}/phosphor-bmc-code-mgmt/bios-release"

PACKAGECONFIG_olympus-nuvoton += "verify_signature"
