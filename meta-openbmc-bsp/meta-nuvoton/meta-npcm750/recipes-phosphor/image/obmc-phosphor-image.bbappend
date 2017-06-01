RDEPENDS += "npcm7xx-flashtool-native"
DEPENDS += "npcm750-bootblock"

add_flash_pbl() {
       bootblock="bootblock.bin"
       fullbootblock="${bootblock}.full"

       create_image --bootblock ${DEPLOY_DIR_IMAGE}/${bootblock} ${ddir}/${fullbootblock}
       dd if=${ddir}/${fullbootblock} of=${dst} bs=1k conv=notrunc
}

add_flash_uboot() {
       fulluboot="${uboot}.full"

       create_image --uboot ${DEPLOY_DIR_IMAGE}/${uboot} ${ddir}/${fulluboot}
       dd if=${ddir}/${fulluboot} of=${dst} bs=1k conv=notrunc seek=44
}
