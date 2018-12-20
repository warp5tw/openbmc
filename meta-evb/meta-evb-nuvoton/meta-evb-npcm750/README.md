# Nuvoton NPCM750 Evaluation Board
This is the Nuvoton NPCM750 evaluation board layer.
The NPCM750 is an ARM based SoC with external DDR RAM and
supports a large set of peripherals made by Nuvoton.
More information about the NPCM7XX can be found
[here](http://www.nuvoton.com/hq/products/cloud-computing/ibmc/?__locale=en).

- Work with [openbmc master branch](https://github.com/openbmc/openbmc/tree/master "openbmc master branch")
- Work with [NTIL linux 4.17.04 for Poleg](https://github.com/Nuvoton-Israel/linux/tree/Poleg-4.17.04-OpenBMC "NTIL")

# Dependencies
![](https://cdn.rawgit.com/maxdog988/icons/61485d57/label_openbmc_ver_master.svg)
![](https://cdn.rawgit.com/maxdog988/icons/master/label_linux_ver_4.13.05.svg)

This layer depends on:

```
  URI: git@github.com:Nuvoton-Israel/openbmc
  branch: master
```

# Contacts for Patches

Please submit any patches against the NPCM750 evaluation board layer to the maintainer of nuvoton:

* Oshri Alkoby, <oshri.alkoby@nuvoton.com>
* Joseph Liu, <KWLIU@nuvoton.com>
* Medad CChien, <CTCCHIEN@nuvoton.com>
* Tyrone Ting, <KFTING@nuvoton.com>
* Stanley Chu, <YSCHU@nuvoton.com>
* Tim Lee, <CHLI30@nuvoton.com>

# Table of Contents

- [Dependencies](#dependencies)
- [Contacts for Patches](#contacts-for-patches)
- [Features of NPCM750 Evaluation Board](#features-of-npcm750-evaluation-board)
  * [WebUI](#webui)
    + [Remote KVM](#remote-kvm)
    + [Serial Over Lan](#serial-over-lan)
    + [Remote Virtual Media](#remote-virtual-media)
    + [BMC Firmware Update](#bmc-firmware-update)
    + [Server Power Operations](#server-power-operations)
  * [System](#system)
    + [Time](#time)
    + [Sensor](#sensor)
    + [LED](#led)
    + [FAN](#fan)
  * [IPMI / DCMI](#ipmi--dcmi)
    + [SOL IPMI](#sol-ipmi)
    + [Message Bridging](#message-bridging)
  * [LDAP for User Management ](#ldap-for-user-management)
    + [LDAP Server Setup](#ldap-server-setup)
  * [Features In Progressing](#features-in-progressing)
  * [Features Planned](#features-planned)
- [IPMI Comamnds Verified](#ipmi-comamnds-verified)
- [Image Size](#image-size)
- [Modifications](#modifications)

# Features of NPCM750 Evaluation Board

## WebUI

### Remote KVM
<img align="right" width="30%" src="https://cdn.rawgit.com/NTC-CCBG/snapshots/e8178eef/openbmc/kvm.png">

This is a Virtual Network Computing (VNC) server programm using [LibVNCServer](https://github.com/LibVNC/libvncserver).
1. Support Video Capture and Differentiation(VCD), compares frame by hardware.
2. Support Encoding Compression Engine(ECE), 16-bit hextile compression hardware encoding.
3. Support USB HID, support Keyboard and Mouse.

The VNC viewer also enabled in webui with below patches.
1. [Implement KVM in webui using novnc module](https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/webui/files/0001-Implement-KVM-in-webui.patch)
	* This patch is provided by [Ed tanous](ed@tanous.net).
2. [Remove sending sec-websocket-protocol in novnc module](https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/webui)

**Source URL**

* [https://github.com/Nuvoton-Israel/obmc-ikvm](https://github.com/Nuvoton-Israel/obmc-ikvm)
* [https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/interfaces/bmcweb/0001-bmcweb-support-obmc-ikvm.patch](https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/interfaces/bmcweb/0001-bmcweb-support-obmc-ikvm.patch)
* [https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/interfaces/phosphor-rest/0001-add-kvm-handler.patch](https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/interfaces/phosphor-rest/0001-add-kvm-handler.patch)

**How to use**

1. Prepare a motherboard with a PCI-E slot at least.
2. Plug Poleg EVB into motherboard with PCI-E connection.
3. Connect a micro usb cable from your workstation to J1 header of Poleg EVB.
4. Connect an ethernet cable between your workstation and J12 header of Poleg EVB.
5. Power up the Poleg EVB and motherboard.
	* Noted the power on sequence to ensure the graphic of Poleg EVB is attached.
      ```
      Poleg EVB -> motherboard
      ```
6. Make sure the network is connected with your workstation.
7. Launch a browser in your workstation and you will see the entry page.
    ```
    /* python web server */
    https://<poelg ip>
    
    /* bmcweb */
    https://<poelg ip>:833
    ```
8. Login to OpenBMC home page
    ```
    Username: root
    Password: 0penBmc
    ```
9. Navigate to KVM viewer page
    ```
    /* python web server */
    https://<poelg ip>/#kvm
    
    /* bmcweb */
    https://<poelg ip>:833/#kvm   
    ```
**Performance**

* Performance tested by playing video
* VNC viewer: [Real VNC viewer](https://www.realvnc.com/en/connect/download/viewer/)

Host Resolution    | FPS    |
:-------------|:------- |
800x600   |  30 fps |
1024x768  |  23 fps   |
1280x1024   |  16 fps |
1600x1200   |  14 fps  |

**Maintainer**

* Joseph Liu

### Serial Over Lan
<img align="right" width="30%" src="https://cdn.rawgit.com/NTC-CCBG/snapshots/e8178eef/openbmc/sol-webui.png">

The Serial over LAN (SoL) console redirects the output of the server’s serial port to a browser window on your workstation.

This is a patch for enabling SOL in [phosphor-webui](https://github.com/openbmc/phosphor-webui) on Nuvoton's NPCM750.

The patch provides the [obmc-console](https://github.com/openbmc/obmc-console) configuration.

It's verified with Nuvoton's NPCM750 solution (which is referred as Poleg here) and Supermicro MBD-X9SCL-F-0.

**Source URL**

* [https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/console](https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/console)

* [https://github.com/Nuvoton-Israel/openbmc-uefi-util/tree/npcm7xx_v2.1/sol_binary](https://github.com/Nuvoton-Israel/openbmc-uefi-util/tree/npcm7xx_v2.1/sol_binary)

**How to use**

1. Prepare a Poleg EVB with up-to-date boot block, Uboot and OpenBMC versions with this SOL patch applied.  Check with Nuvoton support for the most recent versions.

2. Prepare a Supermicro MBD-X9SCL-F-0 motherboard and a LPC cable.

    > _The UEFI firmware version in Supermicro MBD-X9SCL-F-0 for verification is 2.15.1234._

3. Connect pins of the **JTPM** header on **Supermicro MBD-X9SCL-F-0** to the **J10** header on **Poleg EVB** with the LPC cable:

    * Connect **pin 1-3, 5, 7-8, 10-12, 15-17** of JTPM with corresponding pins of J10, **one on one**.

4. Steps to copy UEFI SOL related drivers to a USB drive.  

    * Format the USB drive in FAT or FAT32.  
    * Download PolegSerialDxe.efi and TerminalDxe.efi from  [https://github.com/Nuvoton-Israel/openbmc-uefi-util/tree/npcm7xx_v2.1/sol_binary](https://github.com/Nuvoton-Israel/openbmc-uefi-util/tree/npcm7xx_v2.1/sol_binary) and copy them to the USB drive.

5. Power up the Poleg EVB and steps to prepare a working terminal for Poleg:

    * Download and install the USB-to-UART driver from: [http://www.ftdichip.com/Drivers/VCP.htm](http://www.ftdichip.com/Drivers/VCP.htm) according to the host OS in your workstation.  
    * Connect a micro usb cable from your workstation to J2 header of Poleg EVB.  
    * Wait for the FTDI driver to be installed automatically. The COM port number is assigned automatically.  
    * Open a terminal (e.g., Tera Term version 4.87) and set the correct COM port number assigned by the FTDI driver (in previous step).  
    * The COM port should be configured as follows: **115200, 8 bit, 1 stop-bit, no parity, no flow control**.  
    * Press and release the **PWR-ON-RST (SW3)** button to issue a Power-On-reset.  It's expected to see messages output by Poleg on the terminal. Use the following login name/password to login into Poleg.
        * Login name: **root**  
        * Login password: **0penBmc**  

6. Steps to configure Supermicro MBD-X9SCL-F-0 UEFI setting for SOL:

    * Do not plug any bootable device into Supermicro MBD-X9SCL-F-0.  
    * Power up Supermicro MBD-X9SCL-F-0 and boot into UEFI setting.  
    * Navigate to `Super IO Concifugration` in `Advanced` menu option and enter into `Super IO Concifugration`.  
    * Configure serial port 1 to **IO=3E8h; IRQ=5**, and then disable it.  
    * Go back to the main UEFI setting.  
    * Navigate to `Boot` menu option and select `UEFI: Built-in EFI Shell` as Boot Option #1.  

      + Make sure that the rest boot options are set to **Disabled**.  
    * Navigate to `Exit` menu option and select `Save changes and Reset`.  
    * Press `Yes` in the prompt window and it will reboot then.  
    * Wait for Supermicro MBD-X9SCL-F-0 to boot into UEFI shell.  
    * Plug the USB drive prepared in step-4 into Supermicro MBD-X9SCL-F-0's usb slot.  
    * Input the following command at UEFI shell prompt, press enter key and it will route to UEFI shell again.  
      ```
      exit  
      ```
    * Check the device mapping table of the USB drive in UEFI shell. It is **fs0:** here for example.  
    * Input the following command at UEFI shell prompt, press enter key and the prompt will show **fs0:\>** from now.  
      ```
      fs0:  
      ```
    * Input the following command at UEFI shell prompt and press the enter key.  
      ```
      load PolegSerialDxe.efi  
      ```
    * Input the following command at UEFI shell prompt and press the enter key.  
      ```
      load TerminalDxe.efi  
      ```
    * Unplug the usb drive.  
    * Input the following command at UEFI shell prompt, press the enter key and it will route to the UEFI setting. 
      ```
      exit  
      ```

7. Configure the ethernet communication between your workstation and Poleg EVB:

    * Connect an ethernet cable between your workstation and J7 header of Poleg EVB.  
    * Configure your workstation's ip address to 192.168.0.1 and the netmask to 255.255.255.0 as an example here.  
    * Configure Poleg EVB ip address to 192.168.0.2 and the netmask to 255.255.255.0. For example, input the following command in the terminal connected to Poleg EVB on your workstation and press enter key.  
      ```
	  ifconfig eth0 192.168.0.2 netmask 255.255.255.0
	  ```

8. Run SOL:

    * Please disable the proxy setting for this test if it's configured.
    * Launch a browser in your workstation and navigate to https://192.168.0.2.  
    * Bypass the secure warning and continue to the website.  
    * Enter the BMC Username and Password (defaults: **root/0penBmc**).  
    * You will see the OpenBMC management screen.  
    * Click `Server control` at the left side of the OpenBMC management screen.  
    * A `Serial over LAN console` menu item prompts then and click it.  
    * A specific area will display the UEFI setting of Supermicro MBD-X9SCL-F-0.  
    * (Optional) If the area doesn't display the UEFI setting clearly, use the mouse pointer to click in the area and press the **Esc** key.  
      + It shows a prompt window named `Exit Without Saving`, choose `No` and press enter key to refresh the area for showing UEFI setting entirely.  
    * Please enable the proxy setting if it's just disabled for the test.

**Maintainer**

* Tyrone Ting

### Remote Virtual Media
<img align="right" width="30%" src="https://cdn.rawgit.com/NTC-CCBG/snapshots/1ecfa33/openbmc/vm-own.png">

Virtual Media (VM) is to emulate an USB drive on remote host PC via Network Block Device(NBD) and Mass Storage(MSTG).

**Source URL**

* [https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-support/nbd](https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-support/nbd)
* [https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-kernel/linux/linux-nuvoton/0002-nbd-fix-reconnect.patch](https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-kernel/linux/linux-nuvoton/0002-nbd-fix-reconnect.patch)
* [https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/interfaces/phosphor-rest/0002-add-vm-handler.patch](https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/interfaces/phosphor-rest/0002-add-vm-handler.patch)
* [https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/webui/phosphor-webui/0002-Implement-VM-in-webui.patch](https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/webui/phosphor-webui/0002-Implement-VM-in-webui.patch)

**How to use**

1. Clone a physical usb drive to an image file
    * For Linux - use tool like **dd**
      ```
      dd if=/dev/sda of=usb.img bs=1M count=100
      ```
      > _**bs** here is block size and **count** is block count._
      > 
      > _For example, if the size of your usb drive is 1GB, then you could set "bs=1M" and "count=1024"_

    * For Windows - use tool like **Win32DiskImager.exe**

    > _NOTICE : A simple *.iso file cannot work for this._

2. Switch to webpage of VM on your browser
    ```
    https://XXX.XXX.XXX.XXX/#/vm
    ```
    > _Please login to BMC first._

3. Operations of VM
    * After `Chose File`, click `Start VM` to start VM network service (still not hook USB disk to host platform)
    * After `Start VM`, click `Mount USB` to hook the emulated usb disk to host platform, or click `Stop VM` to stop VM network service.
    * After `Mount USB`, click `UnMount USB` to emulate unplugging the usb disk from host platform
    * After `UnMount USB`, click `Stop VM` to stop VM network service, or click `Mount USB` to hook USB disk to host platform.

**Maintainer**
* Medad CChien

### BMC Firmware Update
<img align="right" width="30%" src="https://cdn.rawgit.com/NTC-CCBG/snapshots/0f22742/openbmc/firmware-update.png">

Virtual Media (VM) is to emulate an USB drive on remote host PC via Network Block Device(NBD) and Mass Storage(MSTG).

**Source URL**

* [https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/images](https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/images)

**How to use**

1. Upload update package from webui, then you will see
    ```
    Activate   
    ```
    > if you select activate, then you will see activation dialog at item 2 
    
    ```
    Delete
    ```
    > If you select delete, then the package will be deleted right now

2. Confirm BMC firmware file activation
    ```
    ACTIVATE FIRMWARE FILE WITHOUT REBOOTING BMC
    ```
    > if you select this, you need to reboot BMC manually, and shutdown application will run update script to flash image into spi flash
    
    ```
    ACTIVATE FIRMWARE FILE AND AUTOMATICALLY REBOOT BMC
    ```
    > if you select this, BMC will shutdown right now, and shutdown application will run update script to flash image into spi flash

**Maintainer**
* Medad CChien

### Server Power Operations
<img align="right" width="30%" src="https://cdn.rawgit.com/NTC-CCBG/snapshots/0f20d6b/openbmc/power.png">

Server Power Operations are using to Power on/Warm reboot/Cold reboot/Orderly shutdown/Immediate shutdown remote host PC.

**Source URL**

* [https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/chassis](https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/chassis)

**How to use**

1. Connect pins of the **PWRON** header on generic motherboard to the **J13** header on Poleg EVB
    * Depending on your motherboard, you need to find **PWRON** header and connect to **pin5-6** of **J13** header on Poleg EVB.

      > _You can check the schematic of Poleg EVB about **J13** that **pin5-6** for **POWER_SW** and **pin3-4** for **RESET_SW**. However, according to `Server power operations` design on WebUI that only use **POWER_SW** pin for `Warm reboot`, `Cold reboot`, `Orderly shutdown` and `Immediate shutdown` function implementation. Thus, we didn't need to use **RESET_SW** pin for those power operations on WebUI._  

2. Configure reaction of power button on generic motherboard's OS
    * When motherboard's OS is running **Linux** and you press **PWRON** header on motherboard, you're prompted with a list of options - this is the **interactive** shutdown. The OS will go **Orderly shutdown** for a while if you didn't select any action from it. If you don't want this interactive shutdown pop up and hope OS go **Orderly shutdown** directly, you can enter below command in terminal before testing:  
      ```
      gsettings set org.gnome.settings-daemon.plugins.power button-power 'shutdown'  
      ```
    * When motherboard's OS is running **Windows** and you press **PWRON** header on motherboard, the default reaction is **Orderly shutdown**. Thus, you didn't need to configure reaction of power button in Windows. But, if you find the default reaction is not **Orderly shutdown**, please check `Control Panel`->`Power Options`->`System Settings` in Windows OS.  

    * About Watchdog patch

      There is a package **phosphor-watchdog** included in OpenBMC now. The watchdog daemon is started on host's power on, which is used to monitor if host is alive. In normal case, when host starts, it will send IPMI commands to kick watchdog and so everything would work fine. If host fails to start, the watchdog eventually timeout. However, the default watchdog timeout action is **HardReset** which is defined at [Watchdog.interface.yaml](https://github.com/openbmc/phosphor-dbus-interfaces/blob/master/xyz/openbmc_project/State/Watchdog.interface.yaml) in **phosphor-dbus-interfaces** that will cause host rebooted after power on.  

      Currently, we just use Poleg EVB with generic motherboard that has some limitations, thus when we use Ubuntu or Windows as host OS, we didn't receive watchdog off IPMI commands sent from OS or BIOS side, so the default watchdog timeout action will be triggered and host will be rebooted after we pressed `Power on` button from `Server control` ->`Server power operations` of WebUI, and that is unexpected behavior. However, we've provided a patch to make `Power on` function work normally for demo purpose, if your host will send watchdog off IPMI command normally then you can remove this patch [0001-Set-Watchdog-ExpireAction-as-None.patch](https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/dbus/phosphor-dbus-interfaces/0001-Set-Watchdog-ExpireAction-as-None.patch) from [phosphor-dbus-interfaces_%.bbappend](https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/dbus/phosphor-dbus-interfaces_%25.bbappend).  

3. Server Power on
    * Press `Power on` button from `Server control` ->`Server power operations` of WebUI.  

      > _[obmc-host-start@.target](https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-phosphor/recipes-core/systemd/obmc-targets/obmc-host-start%40.target) is the one driving the boot of the system._  

4. Server Power off (Soft)
    * Press `Orderly shutdown` button from `Server control` ->`Server power operations` of WebUI.  

      > _The soft server power off function is encapsulated in the [obmc-host-shutdown@.target](https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-phosphor/recipes-core/systemd/obmc-targets/obmc-host-shutdown%40.target) that is soft in that it notifies the host of the power off request and gives it a certain amount of time to shut itself down._  

5. Server Power off (Hard)
    * Press `Immediate shutdown` button from `Server control` ->`Server power operations` of WebUI.  

      > _The hard server power off is encapsulated in the [obmc-chassis-hard-poweroff@.target](https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-phosphor/recipes-core/systemd/obmc-targets/obmc-chassis-hard-poweroff%40.target) that will force the stopping of the soft power off service if running, and immediately cut power to the system._  

6. Server Reboot (Warm)
    * Press `Warm reboot` button from `Server control` ->`Server power operations` of WebUI.  

      > _The warm reboot of the server is encapsulated in the [obmc-host-reboot@.target](https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-phosphor/recipes-core/systemd/obmc-targets/obmc-host-reboot%40.target) that will utilize the server power off (soft) target [obmc-host-shutdown@.target](https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-phosphor/recipes-core/systemd/obmc-targets/obmc-host-shutdown%40.target) and then, once that completes, start the host power on target [obmc-host-start@.target](https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-phosphor/recipes-core/systemd/obmc-targets/obmc-host-start%40.target)._  

7. Server Reboot (Cold)
    * Press `Cold reboot` button from `Server control` ->`Server power operations` of WebUI.  

      > _The cold reboot of the server is shutdown server immediately, then restarts it. This target will utilize the Immediate shutdown target [obmc-chassis-hard-poweroff@.target](https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-phosphor/recipes-core/systemd/obmc-targets/obmc-chassis-hard-poweroff%40.target) and then, start the host power on target [obmc-host-start@.target](https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-phosphor/recipes-core/systemd/obmc-targets/obmc-host-start%40.target)._  

**Maintainer**
* Tim Lee


## System

### Time
  * **SNTP**  
    	Network Time Protocol (NTP) is a networking protocol for clock synchronization between computer systems over packet-switched, variable-latency data networks.

    **systemd-timesyncd** is a daemon that has been added for synchronizing the system clock across the network. It implements an **SNTP (Simple NTP)** client. This daemon runs with minimal privileges, and has been hooked up with **systemd-networkd** to only operate when network connectivity is available.
        
    The modification time of the file **/var/lib/systemd/timesync/clock** indicates the timestamp of the last successful synchronization (or at least the **systemd build date**, in case synchronization was not possible).
    
    **Source URL**
    * [https://github.com/systemd/systemd/tree/master/src/timesync](https://github.com/systemd/systemd/tree/master/src/timesync)
    
    **How to use**  
    <img align="right" width="30%" src="https://cdn.rawgit.com/NTC-CCBG/snapshots/f38b505/openbmc/ntp.png">
    * Enable NTP by **Web-UI** `Server configuration`  
      ->`Date and time settings`
    * Enable NTP by command  
      ```
      timedatectl set-ntp true  
      ```
      >_timedatectl result will show **systemd-timesyncd.service active: yes**_ 
    
      If NTP is Enabled and network is Connected (Using **eth2** connect to router), we will see the item **systemd-timesyncd.service active** is **yes** and **System clock synchronized** is **yes**. Thus, system time will sync from NTP server to get current time.
    * Get NTP status  
      ```
      timedatectl  
      ```
      >_Local time: Mon 2018-08-27 09:24:51 UTC  
      >Universal time: Mon 2018-08-27 09:24:51 UTC  
      >RTC time: n/a  
      >Time zone: n/a (UTC, +0000)  
      >**System clock synchronized: yes**  
      >**systemd-timesyncd.service active: yes**  
      >RTC in local TZ: no_  
      
    * Disable NTP  
      ```
      timedatectl set-ntp false  
      ```
      >_timedatectl result will show **systemd-timesyncd.service active: no**_  
      
    * Using Local NTP server Configuration  
    When starting, systemd-timesyncd will read the configuration file from **/etc/systemd/timesyncd.conf**, which looks like as below: 
        >_[Time]  
        >\#NTP=  
        >\#FallbackNTP=time1.google.com time2.google.com time3.google.com time4.google.com_  
    
    	By default, systemd-timesyncd uses the Google Public NTP servers **time[1-4].google.com**, if no other NTP configuration is available. To add time servers or change the provided ones, **uncomment** the relevant line and list their host name or IP separated by a space. For example, we setup NB windows 10 system as NTP server with IP **192.168.1.128**  
        >_[Time]  
        >**NTP=192.168.1.128**  
    	>\#FallbackNTP=time1.google.com time2.google.com time3.google.com time4.google.com_
    
    * Poleg connect to local NTP server of windows 10 system  
      Connect to NB through **eth0** EMAC interface, and set static IP **192.168.1.15**  
    
      ```
      ifconfig eth0 up
      ifconfig eth0 192.168.1.15
      ```  
      >_Note: Before that you need to setup your NTP server (192.168.1.128) on Windows 10 system first_  
      
      Modify **/etc/systemd/timesyncd.conf** file on Poleg as we mentioned
        >_[Time]  
        >**NTP=192.168.1.128**_  
      
      Re-start NTP to make effect about our configuration change  
      ```
      systemctl restart systemd-timesyncd.service
      ```  
      Check status of NTP that show already synced to our local time server 
      ```
      systemctl status systemd-timesyncd.service -l --no-pager
      ```  
      >_Status: "Synchronized to time server 192.168.1.128:123 (192.168.1.128)."_  
      
      Verify **Web-UI** `Server overview`->`BMC time` whether sync from NTP server as same as **timedatectl**. (Note: timedatectl time zone default is UTC, thus you will find the BMC time is UTC+8)
      ```
      timedatectl  
      ```
      >_Local time: Thu 2018-09-06 07:24:16 UTC  
      >Universal time: Thu 2018-09-06 07:24:16 UTC  
      >RTC time: n/a  
      >Time zone: n/a (UTC, +0000)  
      >System clock synchronized: yes  
      >systemd-timesyncd.service active: yes  
      >RTC in local TZ: no_  

  * **Time settings**  
    **Phosphor-time-manager** provides two objects on D-Bus
      >_/xyz/openbmc_project/time/bmc  
      >
      > >/xyz/openbmc_project/time/host_  

      **BMC time** is used by journal event log record, and **Host time** is used by Host do IPMI Set SEL Time command to sync BMC time from Host mechanism in an era of BMC without any network interface.  
      Currently, we cannot set Host time no matter what we use **busctl**, **REST API** or **ipmitool set time set** command. Due to **phosphor-settingd** this daemon set default TimeOwner is BMC and TimeSyncMethod is NTP. Thus, when TimeOwner is BMC that is not allow to set Host time anyway.

      A summary of which cases the time can be set on BMC or HOST

      Mode      | Owner | Set BMC Time  | Set Host Time
      --------- | ----- | ------------- | -------------------
      NTP       | BMC   | Fail to set   | Not allowed (Default setting)
      NTP       | HOST  | Not allowed   | Not allowed
      NTP       | SPLIT | Fail to set   | OK
      NTP       | BOTH  | Fail to set   | Not allowed
      MANUAL    | BMC   | OK            | Not allowed
      MANUAL    | HOST  | Not allowed   | OK
      MANUAL    | SPLIT | OK            | OK
      MANUAL    | BOTH  | OK            | OK

      If user would like to set Host time that need to set Owner to SPLIT in NTP mode or set Owner to HOST/SPLIT/BOTH in MANUAL mode. However, change Host time will not effect BMC time and journal event log timestamp.

    **Set Time Owner to Split**
    ```
    ### With busctl on BMC
    busctl set-property xyz.openbmc_project.Settings \
       /xyz/openbmc_project/time/owner xyz.openbmc_project.Time.Owner \
       TimeOwner s xyz.openbmc_project.Time.Owner.Owners.Split
    
    ### With REST API on remote host
    curl -c cjar -b cjar -k -H "Content-Type: application/json" -X  PUT  -d \
       '{"data": "xyz.openbmc_project.Time.Owner.Owners.Split" }' \
       https://${BMC_IP}/xyz/openbmc_project/time/owner/attr/TimeOwner
    ```
    **TimeZone**  
    According OpenBMC current design that only support UTC TimeZone now, we can use below command to get current support TimeZone on Poleg
    ```
    timedatectl list-timezones
    ```
    **Maintainer**  
* Tim Lee

### Sensor
<img align="right" width="30%" src="https://raw.githubusercontent.com/NTC-CCBG/snapshots/e1d1733/openbmc/sensor.png">  

[phosphor-hwmon](https://github.com/openbmc/phosphor-hwmon) daemon will periodically check the sensor reading to see if it exceeds lower bound or upper bound . If alarm condition is hit and event generating option is on, it calls [phosphor-logging](https://github.com/openbmc/phosphor-logging) API to generate a **Log entry**.  
Later on, ipmi tool on host side can send IPMI command to BMC to get SEL events, [phosphor-host-ipmid](https://github.com/openbmc/phosphor-host-ipmid) will convert the **Log entries** to SEL record format and reply to host.  

**Source URL**
* [https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/dbus](https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/dbus)
* [https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/ipmi](https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/ipmi)
* [https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/sensors](https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/sensors)


**How to use**

* **Configure sensor and event generator**

  * Add Inventory of Sensors

     **Inventory of Sensors** is a map table that defines all types of SEL event BMC can generate. It is constructed from a yaml file, [recipes-phosphor/ipmi/phosphor-ipmi-inventory-sel/config.yaml](https://github.com/openbmc/meta-phosphor/blob/master/recipes-phosphor/ipmi/phosphor-ipmi-inventory-sel/config.yaml)  

     Below is a sample **config.yaml** for Poleg EVB:
       ```
       /xyz/openbmc_project/inventory/system:
         sensorID: 0x01
         sensorType: 0x12
         eventReadingType: 0x6F
         offset: 0x02
       /xyz/openbmc_project/sensors/temperature/temp1/critical_high:
         sensorID: 0x02
         sensorType: 0x01
         eventReadingType: 0x01
         offset: 0x09
       /xyz/openbmc_project/sensors/temperature/temp1/critical_low:
         sensorID: 0x02
         sensorType: 0x01
         eventReadingType: 0x01
         offset: 0x02
       /xyz/openbmc_project/sensors/temperature/temp2/critical_high:
         sensorID: 0x03
         sensorType: 0x01
         eventReadingType: 0x01
         offset: 0x09
       /xyz/openbmc_project/sensors/temperature/temp2/critical_low:
         sensorID: 0x03
         sensorType: 0x01
         eventReadingType: 0x01
         offset: 0x02    
       ```
       > _Please refer to  **Sensor and Event Code Tables** in IPMI 2.0 spec for definition of sensorID, sensorType,  eventReadingType, and offset_  
     
     It defines 4 events which could be generated by 2 temperature sensors on Poleg EVB : 

       Name    | SensorID | SensorType  | EventType | Event Description
       ------- | ----- | ------------- | ------------------- | --------
       temp1   | 2  | Temperature   | Threshold | Upper Critical - going high
	   temp1   | 2  | Temperature   | Threshold | Lower Critical - going low
       temp2   | 3  | Temperature   | Threshold | Upper Critical - going high
	   temp2   | 3  | Temperature   | Threshold | Lower Critical - going low
    
  * Add Sensor Configuration File
  
    Each sensor has a [config file](https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/sensors/phosphor-hwmon%25/obmc/hwmon/ahb/apb) that defines the sensor name and its warning or critical thresholds. These files are located under **recipes-phosphor/sensors/phosphor-hwmon%/obmc/hwmon/apb/**.  

    Below is config for a LM75 sensor on Poleg EVB. The sensor type is **temperature** and its name is **temp2**. It has warning thresholds for **upper** and **lower** bound. The event generating option is also enabled for **WARNHI** and **WARNLO** threshold that forcing the sensor alarm to be recorded in a D-Bus object.
      ```
      LABEL_temp1=temp2
      WARNLO_temp1=28500
      WARNHI_temp1=31000
      EVENT_temp1=WARNHI,WARNLO
      ```

  * Modify D-Bus Sensor Error Metadata interface  
  
    Modify the file [Threshold.metadata.yaml](https://github.com/openbmc/phosphor-dbus-interfaces/blob/master/xyz/openbmc_project/Sensor/Threshold.metadata.yaml) to determine how to format the meta data of event records, like below : 

      ```
      - name: CriticalHigh
         level: ERR
         meta:
           - str: "SENSOR_DATA=%s"
             type: string
         inherits:
           - xyz.openbmc_project.Common.Callout.Inventory
      - name: CriticalLow
        level: ERR
        meta:
          - str: "SENSOR_DATA=%s"
            type: string
        inherits:
          - xyz.openbmc_project.Common.Callout.Inventory
      ```
    **xyz.openbmc_project.Common.Callout.Inventory** is inherited here in order to include **CALLOUT_INVENTORY_PATH** into phosphor-logging Log entry.

* **Dump events**

  * Using WebUI  
  
    In `Event log` page of **WebUI**, the event may contain a related item like below.
    * **CALLOUT_INVENTORY_PATH** means it has association info in **Inventory of Sensors** table and **/xyz/openbmc_project/sensors/temperature/temp2/critical_high** is the key to this map table.  
    * **SENSOR_DATA** is the sensor reading while the event is recorded.  

      ```
       CALLOUT_INVENTORY_PATH=/xyz/openbmc_project/sensors/temperature/temp2/critical_high SENSOR_DATA=31000 _PID=2531
      ```

  * Using IPMI
    
    Use IPMI utilities like **ipmitool** to send command for getting SEL records.  
    ```
    $ sudo ipmitool sel list
    
       1 | 10/04/2018 | 07:08:54 | Temperature #0x03 | Lower Critical going low  | Asserted
       2 | 10/04/2018 | 07:10:39 | Temperature #0x03 | Lower Critical going low  | Asserted
       3 | 10/04/2018 | 07:28:04 | Temperature #0x03 | Upper Critical going high | Asserted
       4 | 10/04/2018 | 07:28:11 | Temperature #0x03 | Upper Critical going high | Asserted
       5 | 10/04/2018 | 07:28:13 | Temperature #0x03 | Upper Critical going high | Asserted
       6 | 10/04/2018 | 07:46:34 | Temperature #0x03 | Upper Critical going high | Asserted
       7 | 10/04/2018 | 07:46:38 | Temperature #0x03 | Upper Critical going high | Asserted
       8 | 10/04/2018 | 07:46:43 | Temperature #0x03 | Upper Critical going high | Asserted
       9 | 10/04/2018 | 07:46:59 | Temperature #0x03 | Upper Critical going high | Asserted
       a | 10/04/2018 | 07:47:24 | Temperature #0x03 | Upper Critical going high | Asserted
       b | 10/04/2018 | 07:47:29 | Temperature #0x03 | Upper Critical going high | Asserted
       c | 10/04/2018 | 07:47:42 | Temperature #0x03 | Upper Critical going high | Asserted
       d | 10/04/2018 | 07:48:37 | Temperature #0x03 | Upper Critical going high | Asserted
       e | 10/04/2018 | 07:48:39 | Temperature #0x03 | Upper Critical going high | Asserted
       f | 10/04/2018 | 07:48:53 | Temperature #0x03 | Upper Critical going high | Asserted
      10 | 10/04/2018 | 09:19:11 | Temperature #0x03 | Lower Critical going low  | Asserted
      11 | 10/04/2018 | 09:20:22 | Temperature #0x03 | Lower Critical going low  | Asserted
      12 | 10/04/2018 | 09:20:24 | Temperature #0x03 | Lower Critical going low  | Asserted
      13 | 10/04/2018 | 09:33:24 | Temperature #0x03 | Upper Critical going high | Asserted
      14 | 10/04/2018 | 09:33:31 | Temperature #0x03 | Upper Critical going high | Asserted
    ```

**Maintainer**

* Stanley Chu 

### LED
<img align="right" width="30%" src="https://raw.githubusercontent.com/NTC-CCBG/snapshots/db6eec1/openbmc/led.png">  

Turning on ServerLED will make **hearbeat** and **identify** leds on EVB start blinking

**Source URL**
* [https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/leds](https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/leds)

**How to use**
* Add enclosure_identify in LED [config file](https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/leds/npcm750-led-manager-config/led.yaml)
  ```
  enclosure_identify:
    heartbeat:
        Action: 'Blink'
        DutyOn: 50
        Period: 1000
    identify:
        Action: 'Blink'
        DutyOn: 50
        Period: 1000

  ```

* Modify BSP layer [config](https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/conf/machine/evb-npcm750.conf) to select npcm750 LED config file
  ```
  PREFERRED_PROVIDER_virtual/phosphor-led-manager-config-native = "npcm750-led-manager-config-native"
  ```

**Maintainer**

* Oshri Alkoby
* Stanley Chu


### FAN
In Poleg, we support four FAN slots and FAN RPMS will dynamic adjustment according temperature variation. However, before using FAN function, you need to provide 12V external power into FLOPPY PWR on Poleg, 12V connect to PIN 4 and GND connect to PIN 2 of FLOPPY PWR.

**Source URL**

Default Web-UI only show one Fan Tach Fan1, and Poleg support four Fan Tach. Thus, we modify this file to support four Fan Tach.
* [https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/sensors/phosphor-hwmon%25/obmc/hwmon/ahb/apb/pwm-fan-controller%40103000.conf](https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/sensors/phosphor-hwmon%25/obmc/hwmon/ahb/apb/pwm-fan-controller%40103000.conf)
  
    **How to use**  
    <img align="right" width="30%" src="https://cdn.rawgit.com/NTC-CCBG/snapshots/5745760/openbmc/fan.png">
    * Monitor FAN RPMS by **Web-UI** `Server health`  
      ->`Sensors`
    * Enable FAN dynamic adjustment with temperature variation by command  
      ```
      systemctl start obmc-chassis-poweron@0.target  
      ```
      
      This command will trigger systemd to execute chassis poweron target this unit. Due to FAN control function related to Host control, if you didn't connect to Host with your Poleg EVB, you can use this command to slmulate FAN control function.
    * Test FAN RPMS by command
      ```
      echo 25 > /sys/class/hwmon/hwmon2/pwm1
      echo 50 > /sys/class/hwmon/hwmon2/pwm2
      echo 100 > /sys/class/hwmon/hwmon2/pwm3
      echo 255 > /sys/class/hwmon/hwmon2/pwm6
      ```
      We can set pwm value (0-255) for pwm1-3, and 6 to control FAN1-4 RPMS value by echo command and the result will show on Web-UI

**Maintainer**  
* Oshri Alkoby
* Tim Lee


## IPMI / DCMI

### SOL IPMI
<img align="right" width="30%" src="https://cdn.rawgit.com/NTC-CCBG/snapshots/e8178eef/openbmc/sol-ipmi.png">

The Serial over LAN (SoL) via IPMI redirects the output of the server’s serial port to a command/terminal window on your workstation.

The user uses the ipmi tool like [ipmiutil](http://ipmiutil.sourceforge.net/) to interact with SOL via IPMI. Here the [ipmiutil](http://ipmiutil.sourceforge.net/) is used as an example.

This is a patch for enabling SOL via IPMI using [phosphor-net-ipmid
](https://github.com/openbmc/phosphor-net-ipmid) on Nuvoton's NPCM750.

The patch integrates [phosphor-net-ipmid](https://github.com/openbmc/phosphor-net-ipmid) into Nuvoton's NPCM750 solution for OpenBMC.

It's verified with Nuvoton's NPCM750 solution (which is referred as Poleg here) and Supermicro MBD-X9SCL-F-0.

**Source URL**

* [https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/images](https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/images)

**How to use**

1. Please follow instructions from step-1 to step-7 in [SOL](#sol) **How to use** section to configure your workstation, NPCM750 solution and Supermicro MBD-X9SCL-F-0.

2. Download the [ipmiutil](http://ipmiutil.sourceforge.net/) according to the host OS in your workstation.

   > _Here it's assumed that the host OS is Windows 7 and ipmiutil for Windows is downloaded and used accordingly._

3. Run SOL:

    * Extract or install the ipmiutil package to a folder in your workstation in advance.  
    * Launch a command window and navigate to that folder.  
    * Input the following command in the command window.  
      ```
      ipmiutil sol -N 192.168.0.2 -U admin -P 0penBmc -J 3 -V 4 -a  
      ```
    * (Optional) If the area doesn't display the UEFI setting clearly, the user could press the **Esc** key once.  

      + It shows a prompt window named `Exit Without Saving`, choose `No` and press enter key to refresh the area for showing UEFI setting entirely.  
    * (Optional) Configure the `Properties` of the command window  to see the entire output of SOL.  
      > _Screen Buffer Size Width: 200_  
        _Screen Buffer Size Height: 400_  
        _Window Size Width: 100_  
        _Window Size Height: 40_

4. End SOL session:

    * Press the "`" key (using the shift key) and "." key at the same time in the command window.  
    * Input the following command in the command window.  
      ```
      ipmiutil sol -N 192.168.0.2 -U admin -P 0penBmc -J 3 -V 4 -d  
      ```

**Maintainer**

* Tyrone Ting
* Stanley Chu

### Message Bridging

BMC Message Bridging provides a mechanism for routing IPMI Messages between different media.

Please refer to [IPMI Website](https://www.intel.com/content/www/us/en/servers/ipmi/ipmi-home.html) for details about Message Bridging.

  * KCS to IPMB
    <img align="right" width="30%" src="https://cdn.rawgit.com/NTC-CCBG/icons/522a8e05/kcs2ipmb.png">

The command "Send Message" is used to routing IPMI messages from KCS to IPMB via System Interface.

Later, the response to the bridged request is received by the BMC and routed into the Receive Message Queue and it is retrieved using a Get Message command.

The patch integrates the [kcsbridge](https://github.com/openbmc/kcsbridge), [ipmid](https://github.com/openbmc/phosphor-host-ipmid) and [ipmbbridge](https://gerrit.openbmc-project.xyz/#/c/openbmc/ipmbbridge/+/11130/) projects.

It's verified with Nuvoton's NPCM750 solution (which is referred as Poleg here) and Supermicro MBD-X9SCL-F-0.

**Source URL**

* [https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/images](https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/images)
* [https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/ipmi](https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/ipmi)
* [https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-kernel/linux](https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-kernel/linux)

**How to use**

1. The user is expected to know how to follow the instructions in the section **Setting up your OpenBMC project** in [Nuvoton-Israel/openbmc](https://github.com/Nuvoton-Israel/openbmc) to build and program an OpenBMC image into Poleg EVBs.  
    * Prepare a PC (which is referred as a build machine here) for building and programming the OpenBMC image.  

      > _The user is also expected to have general knowledge of ACPI/UEFI and know how to update the DSDT table in linux and build/update a linux kernel/driver._  

2. Prepare two Nuvoton Poleg EVBs. One is named Poleg EVB A and the other is Poleg EVB B.

    * Connect **pin 3-4** of J4 on Poleg EVB A with corresponding pins of J4 on Poleg EVB B, **one on one**.  
    * Connect **pin 12** of J3 on Poleg EVB A with corresponding pin of J3 on Poleg EVB B, **one on one**.  
    * The connection needs a **1k** resistor and a **3.3v** supply from Poleg EVB A.  

      > _The component name of 3.3v supply is P4._

3. Follow instructions from step-1, step-2, step-3 and step-5 in [SOL](#sol) **How to use** section to set up your workstation, Poleg EVB A and Supermicro MBD-X9SCL-F-0.  

    > _Follow instructions from step-1 and step-5 in [SOL](#sol) **How to use** section to set up Poleg EVB B_.  

4. Install Ubuntu 14.04 64bit on Supermicro MBD-X9SCL-F-0 for the verification and login as a normal user.  

    > _The user is required to own root privileges on Ubuntu._

5. Poleg EVB A is configured to have its own slave address **0x10**. Poleg EVB B is configured to have its own slave address **0x58**.

    > _Poleg EVB A treats Poleg EVB B as its attached device on SMBUS/I2C bus and vice versa._

6. In the build machine, download [Nuvoton-Israel/openbmc](https://github.com/Nuvoton-Israel/openbmc) git repository.  

    * Download [linux-nuvoton_%.bbappend](https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-patches/recipes-kernel/linux/linux-nuvoton_%25.bbappend) and overwrite the same original file located under **meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-kernel/linux** folder in the downloaded openbmc directory of the build machine.  
    * Download [enable-i2cslave.cfg](https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-patches/recipes-kernel/linux/enable-i2cslave.cfg) under **meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-kernel/linux/linux-nuvoton** folder in the downloaded openbmc directory of the build machine.  
    * Download [0001-meta-evb-npcm750-enable-i2c-slave-function.patch](https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-patches/recipes-kernel/linux/0x10/0001-meta-evb-npcm750-enable-i2c-slave-function.patch) under **meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-kernel/linux/linux-nuvoton** folder in the downloaded openbmc directory of the build machine to configure Poleg EVB A's own slave address as **0x10**.  
    * In the build machine, rebuild the linux kernel for OpenBMC. As an example, enter the following command in a terminal window (build environment is configured in advance):  
      ```
      bitbake -C fetch virtual/kernel
      ```
    * In the build machine, rebuild the OpenBmc image. As an example, enter the following command in a terminal window (build environment is configured in advance):  
      ```
      bitbake obmc-phosphor-image
      ```

    * Follow the section **Programming the images** of [Nuvoton-Israel/openbmc](https://github.com/Nuvoton-Israel/openbmc) to program the updated image into Poleg EVB A.

7. Download patches to meet the requirement of step-5 for Poleg EVB B.

    * Download [0001-meta-evb-npcm750-enable-i2c-slave-function.patch](https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-patches/recipes-kernel/linux/0x58/0001-meta-evb-npcm750-enable-i2c-slave-function.patch) and overwrite the same original file located under **meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-kernel/linux/linux-nuvoton** folder in the downloaded openbmc directory of the build machine to configure Poleg EVB B's own slave address as **0x58**.  
    * In the build machine, rebuild the linux kernel for OpenBMC. As an example, enter the following command in a terminal window (build environment is configured in advance):  
      ```
      bitbake -C fetch virtual/kernel
      ```

    * Download [kcs_to_ipmb_message_bridging.patch](https://github.com/Nuvoton-Israel/openbmc/blob/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-patches/recipes-phosphor/ipmi/phosphor-ipmi-ipmb/kcs_to_ipmb_message_bridging.patch) under the **meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/ipmi/phosphor-ipmi-ipmb** folder in the downloaded openbmc directory of the build machine.  
    * In the build machine, open a terminal window and navigate to the **meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/ipmi/phosphor-ipmi-ipmb** folder in the downloaded openbmc directory.  
    * Enter the following command in the terminal window in the build machine.  
      ```
      patch -p1 < ./kcs_to_ipmb_message_bridging.patch
      ```

    * In the build machine, rebuild the ipmbbridge for OpenBMC. As an example, enter the following command in a terminal window (build environment is configured in advance):  
      ```
      bitbake -C fetch phosphor-ipmi-ipmb
      ```

    * In the build machine, rebuild the OpenBmc image. As an example, enter the following command in a terminal window (build environment is configured in advance):  
      ```
      bitbake obmc-phosphor-image
      ```

    * Follow the section **Programming the images** of [Nuvoton-Israel/openbmc](https://github.com/Nuvoton-Israel/openbmc) to program the updated image into Poleg EVB B.

8. Modify the system interface driver in Ubuntu 14.04 on Supermicro MBD-X9SCL-F-0 to communicate with Poleg EVB A.

    * Download the kernel source code of Ubuntu 14.04 on Supermicro MBD-X9SCL-F-0 and locate the system interface driver source code.  
    * Locate the code in the function **init_ipmi_si** of ipmi_si_intf.c.
      ```
      enum ipmi_addr_src type = SI_INVALID;
      ```

    * Add the code next to the sentence "enum ipmi_addr_src type = SI_INVALID".
      ```
      return -1;
      ```

    * Rebuild the system interface driver and replace ipmi_si.ko of Ubuntu 14.04 with the one just rebuilt on Supermicro MBD-X9SCL-F-0.  

      > _The original ipmi_si.ko is located at /lib/modules/\`$(uname -r)\`/kernel/drivvers/char/ipmi_

    * Undo the "return -1" modification in the function **init_ipmi_si** of ipmi_si_intf.c.  

      + Rebuild the system interface driver again and leave the regenerated ipmi_si.ko in the kernel source code ipmi directory for system interface driver.

    * Reboot Ubuntu 14.04 on Supermicro MBD-X9SCL-F-0.

9. Update the DSDT table in Ubuntu 14.04 on Supermicro MBD-X9SCL-F-0.  

    * Study the section **How to build a custom DSDT into an initrd** of [overriding-dsdt](https://01.org/zh/linux-acpi/documentation/overriding-dsdt) and [initrd_table_override.txt](https://www.kernel.org/doc/Documentation/acpi/initrd_table_override.txt) to override DSDT in the initrd image of Ubuntu 14.04 and rebuild the Ubuntu kernel on Supermicro MBD-X9SCL-F-0.
    * In the DSDT table, update the OEMRevision field in DefinitionBlock.  
    * In the DSDT table, create two objects used for accessing Poleg EVB A KCS devices via 0x4E, 0x4F.  
      ```
      Name (IDTP, 0x0CA4)  
      Name (ICDP, 0x0CA5)  
      ```

    * Locate the code section like below.  
      ```
      Device (SPMI)
      {
          ...
          Name (_STR, Unicode ("IPMI_KCS"))  
          Name (_UID, Zero)
      ```
    * Add the codes below following the sentence "Name (_UID, Zero)".  
      ```
      OperationRegion (IPST, SystemIO, ICDP, One)
      Field (IPST, ByteAcc, NoLock, Preserve)
      {
          STAS,   8
      }
      ```

    * Locate the code section like below in the same SPMI code section just mentioned.  
      ```
      Method (_STA, 0, NotSerialized)
      ...
      If (LEqual (Local0, 0xFF))
      {
      ...
      ```
    * Add the codes below inside the "If" sentence scope.
      ```
      Store (0x11, LDN)
      Store (0x1,  ACTR)
      Store (0x0C, IOAH)
      Store (0xA4, IOAL)
      Store (0x0C, IOH2)
      Store (0xA5, IOL2)
      ```

    * Rebuild the modified DSDT table and regenerate the initrd image of Ubuntu 14.04 on Supermicro MBD-X9SCL-F-0.  
    * Reboot Supermicro MBD-X9SCL-F-0 to load the overriden DSDT.

10. (Optional)Create shell scripts in Ubuntu 14.04 on Supermicro MBD-X9SCL-F-0.

    * The scripts here are just for convenience and for reference.  
    * Download and build [ioport-1.2.tar.gz](https://people.redhat.com/rjones/ioport/files/ioport-1.2.tar.gz).  

      + Locate the generated **outb** executive.
    * Create a script named "kcs_switch.sh" for example to configure the access to the kcs device of Poleg EVB A from Supermicro MBD-X9SCL-F-0.  
    * The user needs to modify the path to the outb executive in the script (kcs_switch.sh) below.  
      ```
      #!/bin/sh
      outb 0x4e 0x07
      outb 0x4f 0x11

      outb 0x4e 0x30
      outb 0x4f 0x1

      outb 0x4e 0x60
      outb 0x4f 0x0C
      outb 0x4e 0x61
      outb 0x4f 0xA4
      outb 0x4e 0x62
      outb 0x4f 0x0C
      outb 0x4e 0x63
      outb 0x4f 0xA5
      ```

     * Create a script name "insert_ipmi_mod.sh" for example to use the regenerated KCS driver in the kernel source code ipmi directory metioned in step-8.  
     * The user needs to modify the path to the KCS driver in insert_ipmi_mod.sh below.  

       ```
       #!/bin/sh
       sudo insmod ./ipmi_devintf.ko
       sudo insmod ./ipmi_si.ko
       ```

    * Make sure that two scripts above are executable.

11. Install the ipmiutil in Ubuntu 14.04 on Supermicro MBD-X9SCL-F-0.

    * Download, extract, build and install [ipmiutil-3.1.2.tar.gz](http://sourceforge.net/projects/ipmiutil/files/ipmiutil-3.1.2.tar.gz).  
    * Open a terminal window and navigate to the extracted folder of ipmiutil-3.1.2.tar.gz.  
    * Input the following command in the terminal window.
      ```
      sudo ./scripts/ipmi_if.sh
      ```
    * This generates /var/lib/ipmiutil/ipmi_if.txt.  
    * Edit /var/lib/ipmiutil/ipmi_if.txt with the root privilege. 
    * The value for "Base Address:" is **0x0000000000000CA2 (I/O)** and modify it to **0x0000000000000CA4 (I/O)**.

12. Test message bridging.

    * Power up or reboot Poleg EVB A and Poleg EVB B. Make sure that login screens of Poleg EVBs are displayed on the terminal window (e.g. Tera Term) on your workstation.
    * Power up or reboot Supermicro MBD-X9SCL-F-0 and login into Ubuntu 14.04 as a normal user.  
      + Open a terminal window and execute **kcs_switch.sh** and **insert_ipmi_mod.sh** created in step-10 with the root privilege.
      + If the scripts are not created, input the contents of **kcs_switch.sh** and **insert_ipmi_mod.sh** except the #!/bin/sh line manually.
      + The user can use the following command in a terminal window under Ubuntu 14.04 on Supermicro MBD-X9SCL-F-0 to verify Poleg system interface.
        ```
        dmesg | grep -i "bmc"
        ```
      
      + The user can check the man_id. For example, the man_id is **0x000000** for this case.
    * Enter the following command in a terminal window as a normal user of Ubuntu 14.04 on Supermicro MBD-X9SCL-F-0.  
      ```
      sudo ipmiutil cmd 18 34 02 10 18 d8 20 0e 01 d1 -x -s -j -F kcs
      ```
      > _The example command in the data field of "Send Message" command is "Get Device ID"._

    * Enter the following command in a terminal window as a normal user of Ubuntu 14.04 on Supermicro MBD-X9SCL-F-0.  
      ```
      sudo ipmiutil cmd 18 33 -x -s -j -F kcs
      ```
      > _The response to "Get Device ID" command might be "respData[len=26]: 1c 33 00 02 1e c2 58 00 01 00 00 00 02 03 02 00 00 00 00 00 00 00 00 00 00 a0"._


**Maintainer**

* Stanley Chu
* Tyrone Ting

## LDAP for User Management
<img align="right" width="30%" src="https://cdn.rawgit.com/NTC-CCBG/snapshots/b6fdec0d/openbmc/ldap-login-via-ssh.png">

The Lightweight Directory Access Protocol (LDAP) is an open, vendor-neutral, industry standard application protocol for accessing and maintaining distributed directory information services over an Internet Protocol (IP) network.

LDAP is specified in a series of Internet Engineering Task Force (IETF) Standard Track publications called Request for Comments (RFCs), using the description language ASN.1.

A common use of LDAP is to provide a central place to store usernames and passwords. This allows many different applications and services to connect to the LDAP server to validate users.

**Source URL**

* [https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/dlc/ldap-support-user-management](https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/dlc/ldap-support-user-management)
* [https://github.com/Nuvoton-Israel/openbmc-util/tree/master/ldap_server](https://github.com/Nuvoton-Israel/openbmc-util/tree/master/ldap_server)

### LDAP Server Setup

**How to use**

1. The user is expected to know how to follow the instructions in the section **Setting up your OpenBMC project** in [Nuvoton-Israel/openbmc](https://github.com/Nuvoton-Israel/openbmc) to build and program an OpenBMC image into Poleg EVBs. 
    > _Prepare a PC which builds OpenBMC. (called the build machine hereafter)_  
    > _The user is also expected to have knowledge of LDAP and its operations._

2. Install Ubuntu 16.04 64 bit (called Ubuntu hereafter) on a PC which is used as a LDAP server and login into it with an account with root privilege.

3. Set up the LDAP server and its configurations in Ubuntu. 

    * Open a terminal and input the following commands to install required software packages in advance.

      ```
      sudo apt-get install git
      sudo apt-get install libsasl2-dev
      sudo apt-get install g++
      wget http://download.oracle.com/berkeley-db/db-4.8.30.zip
      unzip db-4.8.30.zip
      cd db-4.8.30
      cd build_unix/
      ../dist/configure --prefix=/usr/local --enable-cxxmake
      sudo make install
      ```
    * Install OpenSSL
      + Download [openssl-1.0.2j.tar.gz](https://ftp.openssl.org/source/old/1.0.2/openssl-1.0.2j.tar.gz).
      + Extract openssl-1.0.2j.tar.gz.
      + Open a terminal, navigate to the extracted folder and input the following commands to install OpenSSL.
        ```
        ./config shared --prefix=/usr/local
        make
        make test
        sudo make install
        ```
    * Install OpenLDAP
      + Download OpenLDAP from [https://github.com/openldap/openldap](https://github.com/openldap/openldap)

        > _git clone https://github.com/openldap/openldap_

      + Open a terminal and input the following command to build and install OpenLDAP.
        ```
        ./configure CPPFLAGS="-I/usr/local/include -I/usr/local/include/openssl" LDFLAGS="-L/usr/local/lib -Wl,-rpath,/usr/local/lib" --prefix=/usr/local  --enable-syncprov=yes --enable-crypt=yes --enable-accesslog=yes --enable-auditlog=yes --enable-constraint=yes --enable-ppolicy=yes --enable-modules --enable-mdb --enable-spasswd --enable-debug=yes --enable-syslog --enable-slapd --enable-cleartext --enable-monitor --enable-overlays -with-threads --enable-rewrite --enable-syncprov=yes --with-tls=openssl 
        ```
          > _The description above is one line only._

        ```
        make depend 
        make
        sudo make install
        ```
    * Execute LDAP server
      + Open a terminal and input the following command.

        ```
        sudo /usr/local/libexec/slapd -d 1 -h 'ldaps:/// ldap:/// ldapi:///'
        ```
          > _To stop LDAP server execution, press Ctrl key and C key at the same time in the terminal._  
          > _Now please stop the LDAP server execution._

    * Generate security configurations for the LDAP server running in Ubuntu.

      + Generate the CA key and cert. Open a terminal and input the following commands.
        ```
        openssl ecparam -genkey -name prime256v1 -out ca_server.key  
        openssl req -x509 -new -key ca_server.key -days 3650 -out ca_server.pem -subj '/C=OO/ST=OO/L=OO/O= OO/OU= OO /CN= OO'
        ```

        > _Define these **OO** according to your configurations._

      + Generate the LDAP key and CSR. In the same terminal, input the following commands.
        ```
        openssl ecparam -genkey -name prime256v1 -out ldap_server.key  
        openssl req -new -key ldap_server.key -out ldap_server.csr -subj '/C=OO /ST=OO /L=OO/O=OO/OU=OO/CN=OO'
        ```

        > _Define these **OO** according to your configurations._

      + Generate ldap cert signed with CA cert. In the same terminal, input the following command.
        ```
        openssl x509 -req -days 365 -CA ca_server.pem -CAkey ca_server.key -CAcreateserial -CAserial serial -in ldap_server.csr -out ldap_server.pem
        ```

    * Store and specify locations of keys and certs.
      + Edit /usr/local/etc/openldap/slapd.conf in Ubuntu with root privilege to update fields as examples shown below.
        > _TLSCACertificateFile /etc/ldap/ca_certs.pem_
        > _TLSCertificateFile /etc/ssl/certs/ldap_server.pem_
        > _TLSCertificateKeyFile /etc/ssl/private/ldap_server.key_
        > _TLSCACertificatePath /etc/ldap_
      
      + Copy ca_certs.pem, ldap_server.pem and ldap_server.key into locations specified above with root privilege.

    * Add LDAP schema and LDIF.
      + Download [user_exp.schema](https://github.com/Nuvoton-Israel/openbmc-util/blob/master/ldap_server/schema/user_exp.schema) and save it at /usr/local/etc/openldap/schema with root privilege in Ubuntu.
      + Modify /usr/local/etc/openldap/slapd.conf in Ubuntu with root privilege to specify the schema just saved.
        > _include /usr/local/etc/openldap/schema/user_exp.schema_

      + Download [ap_group.ldif](https://github.com/Nuvoton-Israel/openbmc-util/blob/master/ldap_server/ldif/ap_group.ldif) to a temporary folder in Ubuntu.
      + Download [bmc.ldif](https://github.com/Nuvoton-Israel/openbmc-util/blob/master/ldap_server/ldif/bmc.ldif) to a temporary folder in Ubuntu.
      + Download [group.ldif](https://github.com/Nuvoton-Israel/openbmc-util/blob/master/ldap_server/ldif/group.ldif) to a temporary folder in Ubuntu.
      + Download [people.ldif](https://github.com/Nuvoton-Israel/openbmc-util/blob/master/ldap_server/ldif/people.ldif) to a temporary folder in Ubuntu.
      + Download [privRole.ldif](https://github.com/Nuvoton-Israel/openbmc-util/blob/master/ldap_server/ldif/privRole.ldif) to a temporary folder in Ubuntu.
      + Open a terminal, navigate to the temporary folder for storing LDIF and input the following commands to add these LDIF into the LDAD server in Ubuntu.
        ```
        sudo slapadd -l ./ap_group.ldif
        sudo slapadd -l ./bmc.ldif
        sudo slapadd -l ./group.ldif
        sudo slapadd -l ./people.ldif
        sudo slapadd -l ./privRole.ldif
        ```

    * Execute LDAP server.
      + Open a terminal and input the following command in the terminal.
      ```
      sudo /usr/local/libexec/slapd -d 1 -h 'ldaps:/// ldap:/// ldapi:///'
      ```

4. Setup LDAP client configuration on Poleg.

    * Open a terminal in the build machine and navigate to the directory which contains OpenBMC source codes. The directory is called **OPENBMCDIR** hereafter.
      + Copy all directories and their containing files from [https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/dlc/ldap-support-user-management](https://github.com/Nuvoton-Israel/openbmc/tree/master/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/dlc/ldap-support-user-management) under OPENBMCDIR/meta-evb/meta-evb-nuvoton/meta-evb-npcm750 directory according to their default hierarchy.

    * Update OPENBMCDIR/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/recipes-phosphor/nss-pam-ldapd/files/nslcd.conf. (optional)
      + The IP address for the LDAP server in Ubuntu is configured as **192.168.0.101**. Modify the field **uri ldap** in nslcd.conf according to your network configuration.
        > _uri ldap://192.168.0.101/_
      
    * In the build machine, open a terminal window (build environment is configured in advance and the working directory is at OPENBMCDIR/build) to input the following commands to build the OpenBMC image.
      ```
      bitbake -C fetch libpam
      bitbake -C fetch pamela
      bitbake -C fetch nss-pam-ldapd
      bitbake -C fetch dropbear
      bitbake -C fetch phosphor-rest
      bitbake -C fetch phosphor-webui
      bitbake obmc-phosphor-image
      ```
    * Follow the section **Programming the images** of [Nuvoton-Israel/openbmc](https://github.com/Nuvoton-Israel/openbmc) to program the updated image into Poleg.

5. Test LDAP server.

   * Connect Poleg(J12 header) to the PC running Ubuntu with an ethernet cable and power on Poleg.
   * Login into Poleg from the console program (like Tera Term) with the root account (root/0penBmc).
     > _The console program is used to display a debug console provided by Poleg._

   * Set up IP addresses for Poleg and Ubuntu so that they can ping each other.
     + For example, set Poleg's IP address to 192.168.0.2. Input the following command in the console program.
       ```
       ifconfig eth2 192.168.0.2
       ```

       > _Please replace **192.168.0.2** with your IP configuration for Poleg._
   * Execute the following command in the console program.
     ```
     ldapsearch -ZZ -h 192.168.0.101 -D "cn=admin,dc=ldap,dc=example,dc=com" -b "dc=ldap,dc=example,dc=com" -w secret
     ```  
     > _Please replace **192.168.0.101** with your IP configuration for Ubuntu._  
     > _The ldapsearch example is to display all the data stored in the LDAP server using a TLS connection._
   * You could use the account **user1** stored in the LDAP server to login into WebUI running on Poleg.
     + Use an LDAP tool to modify the field **macAddress** of the DN **bmc-uid=bmc1,ou=bmc,dc=ldap,dc=example,dc=com** stored in the LDAP server.
       > _The modification is to use the mac address of the ethernet module on the Poleg EVB you currently test with._

     + To get the mac address desired, input the following command in the console program.
       ```
       ifconfig eth0
       ```
       > _Locate the keyword **HWaddr** displayed in the console program._  
       > _Copy the value next to HWaddr to override the value of the field **macAddress** of the DN **bmc-uid=bmc1,ou=bmc,dc=ldap,dc=example,dc=com**._

     + Launch a browser and navigate to the Poleg's IP address.
       > _Bypass the secure warning and continue to the website._

     + Use user1/123 to login into WebUI.
       > _user1 is the login ID._  
       > _123 is the login password._

   * Password modification is also available to LDAP accounts via WebUI.
     + Login into WebUI using user1/123 as mentioned in previous phrase.
     + Navigate to `Users` menu item on the left panel and selec it.
     + A sub menu item `Manage user account` pops up and select it.
     + Input the current password value for user1.
       > _The password is set to 123 by default._  
       > _The input location is right below **CURRENT PASSWORD** text area._

     + Input a new password twice.
       > _The input locations are right below **NEW PASSWORD** and **RETYPE NEW PASSWORD** text area._

     + Press the `Save change` button.
       > _A message **Success! User Password has been changed!** is expected to show then._

     + Logout WebUI and login in again with the new password for user1.

    * Login into Poleg via SSH using an LDAP account.
      + Make sure that configurations stated in Step 5 for Poleg and Ubuntu are set accordingly and ping between Ubuntu and Poleg is okay.
      + Install **ssh** in Ubuntu with root privilege if ssh client is not available. Open a terminal and input the following command.
        ```
        sudo apt-get install ssh
        ```

      + Open a terminal in Ubuntu to login into Poleg using the LDAP account **user1** and its password via SSH. Input the following command in the terminal.
        ```
        ssh user1@192.168.0.2
        ```
        > _Please replace **192.168.0.2** with your IP configuration for Poleg._

**Maintainer**

* Tyrone Ting

## Features In Progressing
* User management
* Host power control/monitor
* JTAG - FPGA/CPLD Programing
* Verified Boot - Kernel/ROFS verification
* Remote USB- Standalone VM application
* Remote KVM - V4L2 for KVM

## Features Planned
* Improve sensor/event framework
* Host firmware update
* FRU implementation
* Boot control
* Red fish



# IPMI Comamnds Verified

| Command | KCS | RMCP+ | IPMB |
| :--- | :---: | :---: | :---: |
| **IPM Device Global Commands** |  |  |  |
| Device ID | V | V | V |
| Cold Reset | V |  | V |
| Warm Reset | V |  | V |
| Get Self Test Results | V |  | V |
| Manufacturing Test On |  |  |  |
| Set ACPI Power State | V |  | V |
| Get ACPI Power State |  |  |  |
| Get Device GUID | V |  | V |
| Get NetFn Support |  |  |  |
| Get Command Support |  |  |  |
| Get Command Sub-function Support |  |  |  |
| Get Configurable Commands |  |  |  |
| Get Configurable Command Sub-functions |  |  |  |
| Set Command Enables |  |  |  |
| Get Command Enables |  |  |  |
| Set Command Sub-function Enables |  |  |  |
| Get Command Sub-function Enables |  |  |  |
| Get OEM NetFn IANA Support |  |  |  |
| **BMC Watchdog Timer Commands** |  |  |  |
| Reset Watchdog Timer | V |  | V |
| Set Watchdog Timer | V |  | V |
| Get Watchdog Timer | V |  | V |
| **BMC Device and Messaging Commands** |  |  |  |
| Set BMC Global Enables |  |  |  |
| Get BMC Global Enables |  |  |  |
| Clear Message Flags |  |  |  |
| Get Message Flags | V |  | V |
| Enable Message Channel Receive |  |  |  |
| Get Message | V |  |  |
| Send Message | V |  |  |
| Read Event Message Buffer | V |  | V |
| Get System GUID | V |  | V |
| Set System Info Parameters |  |  |  |
| Get System Info Parameters |  |  |  |
| Get Channel Authentication Capabilities |  | V |  |
| Get Session Challenge |  |  |  |
| Activate Session |  |  |  |
| Set Session Privilege Level |  | V |  |
| Close Session |  | V |  |
| Get Session Info |  |  |  |
| Get AuthCode |  |  |  |
| Set Channel Access |  |  |  |
| Get Channel Access |  |  |  |
| Get Channel Info Command |  |  |  |
| User Access Command |  |  |  |
| Get User Access Command |  |  |  |
| Set User Name |  |  |  |
| Get User Name Command |  |  |  |
| Set User Password Command |  |  |  |
| Activate Payload |  | V |  |
| Deactivate Payload |  | V |  |
| Get Payload Activation Status |  | V |  |
| Get Payload Instance Info |  | V |  |
| Set User Payload Access |  |  |  |
| Get User Payload Access |  |  |  |
| Get Channel Payload Support |  |  |  |
| Get Channel Payload Version |  |  |  |
| Get Channel OEM Payload Info |  |  |  |
| Master Write-Read |  |  |  |
| Get Channel Cipher Suites |  |  |  |
| Suspend/Resume Payload Encryption |  |  |  |
| Set Channel Security Keys |  |  |  |
| Get System Interface Capabilities |  |  |  |
| Firmware Firewall Configuration |  |  |  |
| **Chassis Device Commands** |  |  |  |
| Get Chassis Capabilities |  |  |  |
| Get Chassis Status |  |  |  |
| Chassis Control |  |  |  |
| Chassis Reset |  |  |  |
| Chassis Identify | V |  | V |
| Set Front Panel Button Enables |  |  |  |
| Set Chassis Capabilities |  |  |  |
| Set Power Restore Policy |  |  |  |
| Set Power Cycle Interval |  |  |  |
| Get System Restart Cause |  |  |  |
| Set System Boot Options |  |  |  |
| Get System Boot Options |  |  |  |
| Get POH Counter |  |  |  |
| **Event Commands** |  |  |  |
| Set Event Receiver |  |  |  |
| Get Event Receiver |  |  |  |
| Platform Event |  |  |  |
| **PEF and Alerting Commands** |  |  |  |
| Get PEF Capabilities |  |  |  |
| Arm PEF Postpone Timer |  |  |  |
| Set PEF Configuration Parameters |  |  |  |
| Get PEF Configuration Parameters |  |  |  |
| Set Last Processed Event ID |  |  |  |
| Get Last Processed Event ID |  |  |  |
| Alert Immediate |  |  |  |
| PET Acknowledge |  |  |  |
| **Sensor Device Commands** |  |  |  |
| Get Device SDR Info | V |  | V |
| Get Device SDR |  |  |  |
| Reserve Device SDR Repository |  |  |  |
| Get Sensor Reading Factors |  |  |  |
| Set Sensor Hysteresis |  |  |  |
| Get Sensor Hysteresis |  |  |  |
| Set Sensor Threshold |  |  |  |
| Get Sensor Threshold |  |  |  |
| Set Sensor Event Enable |  |  |  |
| Get Sensor Event Enable |  |  |  |
| Re-arm Sensor Events |  |  |  |
| Get Sensor Event Status |  |  |  |
| Get Sensor Reading |  |  |  |
| Set Sensor Type |  |  |  |
| Get Sensor Type |  |  |  |
| Set Sensor Reading And Event Status |  |  |  |
| **FRU Device Commands** |  |  |  |
| Get FRU Inventory Area Info |  |  |  |
| Read FRU Data |  |  |  |
| Write FRU Data |  |  |  |
| **SDR Device Commands** |  |  |  |
| Get SDR Repository Info |  |  |  |
| Get SDR Repository Allocation Info |  |  |  |
| Reserve SDR Repository |  |  |  |
| Get SDR |  |  |  |
| Add SDR |  |  |  |
| Partial Add SDR |  |  |  |
| Delete SDR |  |  |  |
| Clear SDR Repository |  |  |  |
| Get SDR Repository Time |  |  |  |
| Set SDR Repository Time |  |  |  |
| Enter SDR Repository Update Mode |  |  |  |
| Exit SDR Repository Update Mode |  |  |  |
| Run Initialization Agent |  |  |  |
| **SEL Device Commands** |  |  |  |
| Get SEL Info | V |  | V |
| Get SEL Allocation Info |  |  |  |
| Reserve SEL | V |  | V |
| Get SEL Entry | V |  | V |
| Add SEL Entry | V |  | V |
| Partial Add SEL Entry |  |  |  |
| Delete SEL Entry | V |  | V |
| Clear SEL | V |  | V |
| Get SEL Time | [V](#time) |  | V |
| Set SEL Time | [V](#time)|  | V |
| Get Auxiliary Log Status |  |  |  |
| Set Auxiliary Log Status |  |  |  |
| Get SEL Time UTC Offset |  |  |  |
| Set SEL Time UTC Offset |  |  |  |
| **LAN Device Commands** |  |  |  |
| Set LAN Configuration Parameters |  |  |  |
| Get LAN Configuration Parameters |  |  |  |
| Suspend BMC ARPs |  |  |  |
| Get IP/UDP/RMCP Statistics |  |  |  |
| **Serial/Modem Device Commands** |  |  |  |
| Set Serial/Modem Mux |  |  |  |
| Set Serial Routing Mux |  |  |  |
| SOL Activating |  |  |  |
| Set SOL Configuration Parameters |  | V |  |
| Get SOL Configuration Parameters |  | V |  |
| **Command Forwarding Commands** |  |  |  |
| Forwarded Command |  |  |  |
| Set Forwarded Commands |  |  |  |
| Get Forwarded Commands |  |  |  |
| Enable Forwarded Commands |  |  | . |

# Image Size
Type          | Size    | Note                                                                                                     |
:-------------|:------- |:-------------------------------------------------------------------------------------------------------- |
image-uboot   |  457 KB | including bootblock for Poleg only                                                                       |
image-kernel  |  4 MB   | linux 4.17 version                                                                                       |
image-rofs    |  20 MB  | bottom layer of the overlayfs, read only                                                                 |
image-rwfs    |  0 MB  | middle layer of the overlayfs, rw files in this partition will be created at runtime,<br /> with a maximum capacity of 1MB|

# Modifications

* 2018.07.23 First release Remote-KVM
* 2018.08.02 First release SOL
* 2018.08.07 Modify Readme.md for adding description about SOL How to use
* 2018.09.07 Update SOL for WebUI and IPMI
* 2018.09.10 Update System/Time/SNTP
* 2018.09.12 Update IPMI Comamnds Verified Table
* 2018.09.13 Update Time settings of System/Time
* 2018.09.13 Update obmc-ikvm part for WebUI
* 2018.09.14 First release VM
* 2018.09.14 Update IPMI Commands Verified Table
* 2018.09.21 Add NTP screen snapshot for System/Time/SNTP
* 2018.10.05 Update webui and  patch of webui and interface and vm-own.png
* 2018.10.11 Add Sensor
* 2018.11.16 Add obmc-ikvm support in bmcweb 
* 2018.11.22 Enable firmware update support 
* 2018.11.23 Update Sensor description about FAN How to use
* 2018.11.29 Update Server power operations of Server control about How to use
* 2018.12.20 Add LDAP server setup and test
