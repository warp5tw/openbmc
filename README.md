# OpenBMC #

[![Build Status](https://openpower.xyz/buildStatus/icon?job=openbmc-build)](https://openpower.xyz/job/openbmc-build/)

The OpenBMC project can be described as a Linux distribution for embedded
devices that have a BMC; typically, but not limited to, things like servers,
top of rack switches or RAID appliances. The OpenBMC stack uses technologies
such as Yocto, Open-Embedded, Systemd and DBus to allow easy customization
for your server platform.


## Setting up your OpenBMC project ##

### 1) Prerequisite ###
- Ubuntu 14.04

```
sudo apt-get install -y git build-essential libsdl1.2-dev texinfo gawk chrpath diffstat
```

- Fedora 23

```
sudo dnf install -y git patch diffstat texinfo chrpath SDL-devel bitbake
sudo dnf groupinstall "C Development Tools and Libraries"
```
### 2) Download the source ###
```
git clone git@github.com:Nuvoton-Israel/openbmc.git -b npcm7xx_v1.99.5_cand1
cd openbmc
```

### 3) Target your hardware ###
Any build requires an environment variable known as `TEMPLATECONF` to be set
to a hardware target.  OpenBMC has placed all known hardware targets in a
standard directory structure `meta-openbmc-machines/meta-openpower/[company]/[target]`.
You can see all of the known targets with `find meta-openbmc-machines -type d -name conf`.
Choose the hardware target and then move to the next step. Additional examples
can be found in the [OpenBMC Cheatsheet](https://github.com/openbmc/docs/blob/master/cheatsheet.md)

Machine | TEMPLATECONF
--------|---------
NPCM750 | ```meta-openbmc-machines/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/conf```
Barreleye | ```meta-openbmc-machines/meta-openpower/meta-rackspace/meta-barreleye/conf```
Zaius| ```meta-openbmc-machines/meta-openpower/meta-ingrasys/meta-zaius/conf```
Witherspoon| ```meta-openbmc-machines/meta-openpower/meta-ibm/meta-witherspoon/conf```


As an example target NPCM750
```
export TEMPLATECONF=meta-openbmc-machines/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/conf
```

### 3) Build ###

```
. openbmc-env
bitbake obmc-phosphor-image
```

Additional details can be found in the [docs](https://github.com/openbmc/docs)
repository.

### 4) build images  ###
After building finished the built Images will found at:
<NPCM7xx folder>/build/tmp/deploy/images/evb-npcm750
The relvant Images to use to upload the OpenBMC on the EVB are:

1. uImage - NPCM750 EVB kernel Image
2. uImage-npcm750.dtb - NPCM750 EVB device tree blob.
3. obmc-phosphor-image-evb-npcm750.cpio.lzma.u-boot - NPCM750 EVB OpenBMC RootFS

Note
---------
All the files above are Image links to the latest build images, 
for copy the files to SD or USB storage device please make sure 
you copying the Images and not the links

### 5) running images  ###
For running OpenBMC on the EVB please do as follow

#### 1) add parameters to the u-boot ###
In u-boot version 201510.6.2 add parameters as follow:

setenv kernel_tftp_path uImage

setenv romfs_tftp_path obmc-phosphor-image-evb-npcm750.cpio.lzma.u-boot

setenv fdt_path uImage-npcm750.dtb

setenv create_images_openbmc 'setenv autostart no;setenv ethact ETH${eth_num};dhcp;tftp ${romaddr} ${openbmc_romfs};setenv romsize ${filesize};tftp ${uimage_addr} ${serverip}:${openbmc_image};tftp ${fdtaddr} ${openbmc_fdt};setenv autostart yes'

setenv openbmc_bootargs 'run common_bootargs;setenv bootargs ${bootargs} root=/dev/ram rw ramdisk_size=48000'

setenv ftp_openbmcboot 'run openbmc_bootargs;run create_images1; bootm ${uimage_addr} $(romaddr) ${fdtaddr}'

setenv ftp_romboot 'run romsize_w_calc;run openbmc_bootargs;cp ${romfs_flash_addr} ${romaddr} ${romsize_w};cp ${fdt_flash_addr} ${fdtaddr} $(fdtsize_w);cp ${uimage_flash_addr} ${uimage_addr} ${kernel_wsize};bootm ${uimage_addr} $(romaddr) ${fdtaddr}'

setenv sdload 'fatload mmc 0 ${uimage_addr} ${kernel_tftp_path};fatload mmc 0 ${romaddr} ${romfs_tftp_path};fatload mmc 0 ${fdtaddr} ${fdt_path}'

setenv sdboot 'run sdload;run openbmc_bootargs;bootm ${uimage_addr} $(romaddr) ${fdtaddr}'

setenv usbload 'usb start;fatload usb 0 ${uimage_addr} ${kernel_tftp_path};fatload usb 0 ${romaddr} ${romfs_tftp_path};fatload usb 0 ${fdtaddr} ${fdt_path}'

setenv usbboot 'run usbload;run openbmc_bootargs;bootm ${uimage_addr} $(romaddr) ${fdtaddr}'

setenv ftp_openbmc 'setenv ethact ETH${eth_num}; run ftp_openbmcboot'

setenv rom_openbmc 'setenv ethact ETH${eth_num}; run ftp_romboot'

setenv romsize 1000000

save the new parameters (saveenv)

#### 2) PROGRAM THE LINUX KERNEL FROM THE HOST MACHINE THROUGH THE TFTP SERVER ####

This section describes how to load and boot the Linux kernel from the TFTP server. This is
very useful in the development stage when doing frequent builds.
These steps below should be performed one time per EVB.
After performing these steps, on each EVB reset, the Linux files are downloaded
automatically from the TFPT to EVB SDRAM and then are booted.

1. Install and set up the TFTP server on your host machine
    - For Windows, use ‘Tftpd32’ or ‘Tftpd64’ from http://tftpd32.jounin.net
	- For Linux, set up the tftp server environment.
2. Copy the "/build/tmp/deploy/images/evb-npcm750" folder, which contains the "uImage", 
   "obmc-phosphor-image-evb-npcm750.cpio.lzma.u-boot" and “uImage-npcm750.dtb“ 
   Linux kernel files, into the TFTP server root folder on the host machine.
3. Power up the EVB and hit any key to stop at the U-Boot shell.
4. Update the U-Boot environment according to your network settings and working method. 
   Pay attention to the following environment settings:
	- Update the MAC address (ethaddr,eth1addr,eth2addr,eth3addr) as printed on your board.
	- Change the Host IP address (gatewayip and serverip) according to your network
	  parameters
	- Change the EVB static IP address (ipaddr) in case the EVB uses static IP rather than
	  dynamic IP.
	- Change the Linux file location in the FTP (tftp_dir).
	- Change the Ethernet connection (eth_num). The EVB supports an RMII-1 or RGMII-1
	  Ethernet connection.
5. Change the bootcmd environment to boot from the TFTP, as follows:
   setenv bootcmd 'setenv ethact ETH${eth_num}; run ftp_openbmc'
6. Connect an Ethernet cable between the EVB (RMII-1 or RGMII-1, according to the
   eth_num configuration) and the host machine (the connection can be through your
   work network).
8. Type "run bootcmd" or reset the EVB, This loads the Linux kernel files from the host
   machine through the TFTP server to EVB SDRAM, and performs the boot.
   
Note: To program the Linux to the flash, type "run create_images" and press <ENTER>.
This loads the Linux kernel files from the TFTP to SDRAM and programs them into
the flash device. Remember to update the bootcmd environment back to ‘run
rom_openbmc' and save the environment to the SPI flash device in order to be able to boot
from the flash device after an EVB reset.

#### 3) PROGRAMMING THE LINUX KERNEL FROM SD CARD OR USB STORAGE DEVICE TO THE SPI FLASH ####

This section desribes how to program the Linux kernel to the flash from eitheran SD card or
a USB storage device.
Prepare the SD card or USB storage device with a FAT file system (FAT16 or FAT32) and
verify that there is at least 32 MB of free space available for the Linux kernel files.

1. Copy the "uImage", "obmc-phosphor-image-evb-npcm750.cpio.lzma.u-boot" and 
    “uImage-npcm750.dtb“ Linux kernel files into the root
    directory of either the SD card or USB storage device.
2. Plug the SD card or USB storage device into the EVB.
3. Power up the EVB and hit any key to stop at the U-Boot shell.
   
Note: To skip flash programming and boot Linux from SDRAM, skip steps 4-7 and type
either "run sdboot" (for an SD card) or "run usbboot" (for USB storage). Press
<ENTER>. This loads Linux kernel files to SDRAM and boots it.

4. Type either "run sdload" (for an SD card) or "run usbload" (for USB storage) and press
   <ENTER>. This loads Linux kernel files to SDRAM.
5. Type "run copy_image2flash" and press <ENTER>. This copies the Linux kernel from
   SDRAM to the flash device.
6. Change the bootcmd environment to boot from the TFTP, as follows:
   setenv bootcmd 'setenv ethact ETH${eth_num}; run rom_openbmc'
7. Reset the EVB to run Linux.

#### 4) OpenBMC user login ####
after the OpenBMC boot please enter the following login and password:

```
Phosphor OpenBMC (Phosphor OpenBMC Project Reference Distro) 0.1.0 evb-npcm750 ttyS3

evb-npcm750 login: root
Password: 0penBmc (first letter zero and not capital o)
```

## Contact ##
- Mail: tomer.maimon@nuvoton.com, avi.fishman@nuvoton.com