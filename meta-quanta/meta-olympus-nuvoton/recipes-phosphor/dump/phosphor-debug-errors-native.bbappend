FILESEXTRAPATHS_append := "${THISDIR}/${BPN}:"

SRC_URI += "file://olympus-nuvoton_errors_watch.yaml"

do_install_append() {
    DEST=${D}${datadir}/dump
    install olympus-nuvoton_errors_watch.yaml ${DEST}/errors_watch.yaml
}

