#@TYPE: Machine
#@NAME: Nuvoton NPCM750
#@DESCRIPTION: Common machine configuration for the Nuvoton NPCM750 Chip

PREFERRED_PROVIDER_virtual/kernel ?= "linux-obmc"

UBOOT_MACHINE ?= "PolegSVB_config"
UBOOT_ENTRYPOINT ?= "0x00200000"
UBOOT_LOADADDRESS ?= "0x00200000"

# TODO: verify this!
DEFAULTTUNE = "armv7a"

SERIAL_CONSOLES = "115200;ttyS3"

require conf/machine/include/arm/arch-armv7a.inc
