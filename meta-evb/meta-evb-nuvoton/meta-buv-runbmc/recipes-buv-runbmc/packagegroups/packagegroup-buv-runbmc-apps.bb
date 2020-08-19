SUMMARY = "OpenBMC for BUV Nuvoton system - Applications"
PR = "r1"

inherit packagegroup

PROVIDES = "${PACKAGES}"
PACKAGES = " \
    ${PN}-buv-system \
    ${PN}-buv-common-utils \
    "

SUMMARY_${PN}-buv-common-utils = "BUV NUVOTON common utils"
RDEPENDS_${PN}-buv-common-utils = " \
    ipmitool \
    phosphor-webui \
    phosphor-host-postd \
    loadsvf \
    obmc-console \
    phosphor-sel-logger \
    rsyslog \
    phosphor-host-postd \
    obmc-ikvm \
    "

SUMMARY_${PN}-buv-system = "BUV NUVOTON System"
RDEPENDS_${PN}-buv-system = " \
    dhcpcd \
    intel-ipmi-oem \
    phosphor-ipmi-fru \
    iperf3 \
    "
