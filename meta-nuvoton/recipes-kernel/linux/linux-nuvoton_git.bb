KBRANCH ?= "NPCM-5.10-OpenBMC"
LINUX_VERSION ?= "5.10.14"

#SRCREV="029ec235190f4ded8e9a8f07eaf5eb6ad3cd40e0"
SRCREV="35bf55522b116ff58486345491e9598e5237e93a"

require linux-nuvoton.inc

SRC_URI_append_nuvoton = " file://0001-Revert-mtd-spi-nor-fix-options-for-mx66l51235f.patch"
#SRC_URI_append_nuvoton = " file://0002-add-tps53622-and-tps53659.patch"
#SRC_URI_append_nuvoton = " file://0003-i2c-nuvoton-npcm750-runbmc-integrate-the-slave-mqueu.patch"
SRC_URI_append_nuvoton = " file://0004-driver-ncsi-replace-del-timer-sync.patch"
#SRC_URI_append_nuvoton = " file://0008-WAR-skip-clear-fault-for-flexpower.patch"
#SRC_URI_append_nuvoton = " file://0010-driver-misc-npcm7xx-mcu-flash-add-NPCM-MCU-driver.patch"
#SRC_URI_append_nuvoton = " file://0011-driver-misc-npcm7xx-mcu-flash-fix-mcu-reset-signal-a.patch"
#SRC_URI_append_nuvoton = " file://0012-driver-misc-npcm7xx-mcu-flash-add-npcm7xx_mcu_releas.patch"
SRC_URI_append_nuvoton = " file://0015-driver-misc-nuvoton-vdm-support-openbmc-libmctp.patch"
#SRC_URI_append_nuvoton = " file://0018-dts-runbmc-olympus-add-power-reset-button-and-post-c.patch"
#SRC_URI_append_nuvoton = " file://0019-dts-runbmc-olympus-add-ext1-reset-type-to-wd1-for-wa.patch"

#SRC_URI_append_nuvoton = " file://v4l2.cfg"
#SRC_URI_append_nuvoton = " file://0001-driver-video-nuvoton-add-video-driver.patch"
#SRC_URI_append_nuvoton = " file://0001-dts-workaround-for-FIU-rofs-mounting-issue.patch"
#SRC_URI_append_nuvoton = " file://0001-driver-net-ethernet-nuvoton-fix-the-dma_map_single-w.patch"
#SRC_URI_append_nuvoton = " file://0001-driver-pinctrl-rework-to-get-gpio-names-from-the-dts.patch"
