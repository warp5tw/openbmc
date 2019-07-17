FILESEXTRAPATHS_prepend := "${THISDIR}/${PN}:"

SRCREV = "edf1ab46938b9bb022be98e331ced8deec04d7c6"
SRC_URI += "file://0001-Implement-KVM-in-webui.patch"
SRC_URI += "file://0002-Implement-VM-in-webui.patch"
SRC_URI += "file://0001-Add-user-password-update-support-for-LDAP.patch"

do_compile () {

    cd ${S}
    rm -rf node_modules
    npm --loglevel info --proxy=${HTTP_PROXY} --https-proxy=${HTTPS_PROXY} install
    sed -i -e 's/new WebSocket(uri, protocols)/new WebSocket(uri)/g' node_modules/@novnc/novnc/core/websock.js
    npm run-script build
}


