LICENSE = "Apache-2.0"
LIC_FILES_CHKSUM = "file://LICENSE;md5=b234ee4d69f5fce4486a80fdaf4a4263"

inherit npcm7xx-image

SRC_URI  = " git://github.com/nuvoton-israel/igps.git"
SRC_URI += " file://001-igps-remove-sudo.patch"
SRC_URI[md5sum] = "8240f24eb6ea8d946bd8f7e78265007868565ba8"

SRCREV = "8240f24eb6ea8d946bd8f7e78265007868565ba8"

S = "${WORKDIR}/git"

do_install () {
	install -d ${IGPS_DIR}
	cp -R ./* ${IGPS_DIR}
}

inherit native
