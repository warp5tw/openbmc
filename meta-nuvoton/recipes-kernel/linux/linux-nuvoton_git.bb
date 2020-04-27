KBRANCH ?= "Poleg-5.4-OpenBMC"
LINUX_VERSION ?= "5.4.16"

SRCREV="1705adbd4803bc2e9c622cfb1eff3b0d8bda0698"

require linux-nuvoton.inc

SRC_URI_append_nuvoton = " file://0001-Revert-mtd-spi-nor-fix-options-for-mx66l51235f.patch"
SRC_URI_append_nuvoton = " file://0002-add-tps53622-and-tps53659.patch"
SRC_URI_append_nuvoton = " file://0003-i2c-nuvoton-npcm750-runbmc-integrate-the-slave-mqueu.patch"
SRC_URI_append_nuvoton = " file://0004-driver-ncsi-replace-del-timer-sync.patch"
SRC_URI_append_nuvoton = " file://0006-npcm7xx-misc-vdmx-driver.patch"
SRC_URI_append_nuvoton = " file://0008-WAR-skip-clear-fault-for-flexpower.patch"
SRC_URI_append_nuvoton = " file://0009-driver-media-update-vcd-and-ece.patch"
