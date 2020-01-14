SUMMARY = "OpenBMC for RunBMC BUV board - Applications"
PR = "r1"

inherit packagegroup

PROVIDES = "${PACKAGES}"
PACKAGES = " \
        ${PN}-chassis \
        ${PN}-fans \
        ${PN}-flash \
        ${PN}-system \
        "

PROVIDES += "virtual/obmc-chassis-mgmt"
PROVIDES += "virtual/obmc-fan-mgmt"
PROVIDES += "virtual/obmc-flash-mgmt"
PROVIDES += "virtual/obmc-system-mgmt"

RPROVIDES_${PN}-chassis += "virtual-obmc-chassis-mgmt"
RPROVIDES_${PN}-fans += "virtual-obmc-fan-mgmt"
RPROVIDES_${PN}-flash += "virtual-obmc-flash-mgmt"
RPROVIDES_${PN}-system += "virtual-obmc-system-mgmt"

SUMMARY_${PN}-chassis = "RunBMC BUV board Chassis"
RDEPENDS_${PN}-chassis = " \
        "

SUMMARY_${PN}-fans = "RunBMC BUV board Fans"
RDEPENDS_${PN}-fans = " \
        "

SUMMARY_${PN}-flash = "RunBMC BUV board Flash"
RDEPENDS_${PN}-flash = " \
        "

SUMMARY_${PN}-system = "RunBMC BUV board System"
RDEPENDS_${PN}-system = " \
        phosphor-webui \
        ipmitool \
        "
