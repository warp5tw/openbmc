FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRC_URI += "file://0001-add-kvm-handler.patch"
SRC_URI += "file://0002-add-vm-handler.patch"
SRC_URI += "file://0001-meta-evb-npcm750-Add-support-for-LDAP-login.patch"
SRC_URI += "file://0001-meta-evb-npcm750-Add-user-password-update-support-fo.patch"
