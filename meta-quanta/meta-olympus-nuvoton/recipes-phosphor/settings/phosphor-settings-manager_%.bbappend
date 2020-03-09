FILESEXTRAPATHS_append_olympus-nuvoton := "${THISDIR}/${PN}:"

SRC_URI_append_olympus-nuvoton = " file://chassis-cap.override.yml"
SRC_URI_append_olympus-nuvoton = " file://sol-default.override.yml"
SRC_URI_append_olympus-nuvoton = " file://psu-presence.override.yml"
SRC_URI_append_olympus-nuvoton = " file://psu-redundancy.override.yml"
SRC_URI_append_olympus-nuvoton = " file://pmbus.override.yml"
SRC_URI_append_olympus-nuvoton = " file://puredundancy.override.yml"
SRC_URI_append_olympus-nuvoton = " file://pmbus-decorator.override.yml"
