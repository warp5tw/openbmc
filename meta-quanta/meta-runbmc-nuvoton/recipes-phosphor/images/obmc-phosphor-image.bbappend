FLASH_UBOOT_OFFSET = "0"
FLASH_KERNEL_OFFSET = "2048"
FLASH_ROFS_OFFSET = "8192"
FLASH_RWFS_OFFSET = "29696"

IMAGE_INSTALL_append = " dhcpcd \
                         phosphor-webui \
						 phosphor-ipmi-fru \
                         ipmitool \
                       "
