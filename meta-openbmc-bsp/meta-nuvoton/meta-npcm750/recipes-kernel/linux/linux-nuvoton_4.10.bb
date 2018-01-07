#require linux-nuvoton.inc

KBRANCH = "Poleg-4.10.15-OpenBMC"
SRCREV = "37e95bd7a5ed6e421c6f760b1371a1f6ca249b71"

SRC_URI = "git://github.com/Nuvoton-Israel/linux;protocol=git;branch=${KBRANCH};protocol=https \
		   file://phosphor-gpio-keys.scc \
		   file://phosphor-gpio-keys.cfg \
          "

LINUX_VERSION ?= "4.10.15"
LINUX_VERSION_EXTENSION ?= "-nuvoton"

PR = "r1"
PV = "${LINUX_VERSION}"

S = "${WORKDIR}/git"
#KERNEL_DEVICETREE = "npcm750.dtb"

include linux-nuvoton.inc

#KERNEL_CC += " --sysroot=${PKG_CONFIG_SYSROOT_DIR}"
