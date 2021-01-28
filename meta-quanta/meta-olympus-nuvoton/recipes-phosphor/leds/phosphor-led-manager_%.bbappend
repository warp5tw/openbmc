FILESEXTRAPATHS_prepend_olympus-nuvoton := "${THISDIR}/${PN}:"

SRC_URI_append_olympus-nuvoton = " file://LED_GroupManager.conf"

SYSTEMD_OVERRIDE_${PN}-ledmanager += "LED_GroupManager.conf:xyz.openbmc_project.LED.GroupManager.service.d/LED_GroupManager.conf"

