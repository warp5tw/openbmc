# NPCM750 BUV RunBMC
This is the Nuvoton BUV RunBMC layer.
The NPCM750 is an ARM based SoC with external DDR RAM and
supports a large set of peripherals made by Nuvoton.
More information about the NPCM7XX can be found
[here](http://www.nuvoton.com/hq/products/cloud-computing/ibmc/?__locale=en).

- Working with [openbmc master branch](https://github.com/openbmc/openbmc/tree/master "openbmc master branch")

# Dependencies
![](https://cdn.rawgit.com/maxdog988/icons/61485d57/label_openbmc_ver_master.svg)

This layer depends on:

```
  URI: git@github.com:Nuvoton-Israel/openbmc
  branch: runbmc
```

# Contacts for Patches

Please submit any patches against the meta-buv-runbmc layer to the maintainer of nuvoton:

* Brian Ma, <CHMA0@nuvoton.com>
* Jim Liu, <JJLIU0@nuvoton.com>
* Joseph Liu, <KWLIU@nuvoton.com>

# Build this layer

```
export TEMPLATECONF=meta-evb/meta-evb-nuvoton/meta-buv-runbmc/conf
. openbmc-env
bitbake obmc-phosphor-image
```