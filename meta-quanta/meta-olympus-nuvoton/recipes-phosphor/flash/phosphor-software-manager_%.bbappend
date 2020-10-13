SRC_URI = "git://github.com/Nuvoton-Israel/phosphor-bmc-code-mgmt.git"
SRCREV = "e83d663e1ab4daf4246df80aca6c353f17e50e14"

FILES_${PN}-updater_append_olympus-nuvoton = " \
    ${datadir}/phosphor-bmc-code-mgmt/bios-release \
    ${datadir}/phosphor-bmc-code-mgmt/mcu-release"

PACKAGECONFIG_olympus-nuvoton += "verify_signature"
