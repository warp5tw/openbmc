
# OpenBMC

[![Build Status](https://openpower.xyz/buildStatus/icon?job=openbmc-build)](https://openpower.xyz/job/openbmc-build/)

The OpenBMC project can be described as a Linux distribution for embedded
devices that have a BMC; typically, but not limited to, things like servers,
top of rack switches or RAID appliances. The OpenBMC stack uses technologies
such as [Yocto](https://www.yoctoproject.org/),
[OpenEmbedded](https://www.openembedded.org/wiki/Main_Page),
[systemd](https://www.freedesktop.org/wiki/Software/systemd/), and
[D-Bus](https://www.freedesktop.org/wiki/Software/dbus/) to allow easy
customization for your server platform.


## Setting up your OpenBMC project

### 1) Prerequisite
- Ubuntu 14.04

```
sudo apt-get install -y git build-essential libsdl1.2-dev texinfo gawk chrpath diffstat
```

- Fedora 23

```
sudo dnf install -y git patch diffstat texinfo chrpath SDL-devel bitbake
sudo dnf groupinstall "C Development Tools and Libraries"
```
### 2) Download the source
```
git clone git@github.com:Nuvoton-Israel/openbmc.git
cd openbmc
```

### 3) Target your hardware
Any build requires an environment variable known as `TEMPLATECONF` to be set
to a hardware target.  OpenBMC has placed all known hardware targets in a
standard directory structure
`meta-openbmc-machines/meta-[architecture]/meta-[company]/meta-[target]`.
You can see all of the known targets with
`find meta-openbmc-machines -type d -name conf`. Choose the hardware target and
then move to the next step. Additional examples can be found in the
[OpenBMC Cheatsheet](https://github.com/openbmc/docs/blob/master/cheatsheet.md)

Machine | TEMPLATECONF
--------|---------
EVB NPCM750 | ```meta-openbmc-machines/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/conf```
Barreleye | ```meta-openbmc-machines/meta-openpower/meta-rackspace/meta-barreleye/conf```
Zaius| ```meta-openbmc-machines/meta-openpower/meta-ingrasys/meta-zaius/conf```
Witherspoon| ```meta-openbmc-machines/meta-openpower/meta-ibm/meta-witherspoon/conf```


As an example target NPCM750 evaluation board
```
export TEMPLATECONF=meta-openbmc-machines/meta-evb/meta-evb-nuvoton/meta-evb-npcm750/conf
```

### 5) Build

```
. openbmc-env
bitbake obmc-phosphor-image
```

Additional details can be found in the [docs](https://github.com/openbmc/docs)
repository.

### 6) build images
After building finished the built Images will found at:
<NPCM7xx folder>/build/tmp/deploy/images/evb-npcm750
The relvant Images to use to upload the OpenBMC on the EVB are:

1. uImage - NPCM750 EVB kernel Image
2. uImage-npcm750.dtb - NPCM750 EVB device tree blob.
3. obmc-phosphor-image-evb-npcm750.cpio.lzma.u-boot - NPCM750 EVB OpenBMC RootFS

### Note
All the files above are Image links to the latest build images, 
for copy the files to SD or USB storage device please make sure 
you copying the Images and not the links

#### 7) Running images
For running OpenBMC on the EVB please follow the readme.txt in:
ftp://ftp.nuvoton.co.il/outgoing/Eval_Board at the section:
"Loading to Evaluation Board and running instructions".
In order to get a password for the ftp please contact BMC_Marketing@Nuvoton.com

#### 8) OpenBMC user login
after the OpenBMC boot please enter the following login and password:

```
Phosphor OpenBMC (Phosphor OpenBMC Project Reference Distro) 0.1.0 evb-npcm750 ttyS3

evb-npcm750 login: root
Password: 0penBmc (first letter zero and not capital o)
```


## Contact
- Mail: tomer.maimon@nuvoton.com,  avi.fishman@nuvoton.com or BMC_Marketing@Nuvoton.com
