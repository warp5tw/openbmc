EXTRA_OECONF_olympus-nuvoton += " --disable-link-local-autoconfiguration"

FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"
SRCREV = "40a51df94c7668bf4de8f82b8c578c4a3b409974"

DEPENDS += "nlohmann-json"

SRC_URI_append_olympus-nuvoton = " file://0001-Run-after-xyz-openbmc_project-user-path-created.patch"
SRC_URI_append_olympus-nuvoton = " file://0002-Adding-channel-specific-privilege-to-network.patch"
