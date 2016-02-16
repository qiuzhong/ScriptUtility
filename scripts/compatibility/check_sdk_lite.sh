#!/bin/bash

#
# Check whether the SDK exist
#

CWD=$(pwd)
source ${PWD}/config


check_sdk() {
    VERSION=$1

    if [[ -d ${PKG_TOOLS_LITE_DIR}/crosswalk-${VERSION} ]]; then
        echo "${PKG_TOOLS_LITE_DIR}/crosswalk-${VERSION} exists! -- OK"
    else
        echo "${PKG_TOOLS_LITE_DIR}/crosswalk-${VERSION} does not exist! -- NOOOOOK!"
    fi
}

check_sdk64() {
    VERSION=$1

    if [[ -d ${PKG_TOOLS_LITE_DIR64}/crosswalk-${VERSION}-64bit ]]; then
        echo "${PKG_TOOLS_LITE_DIR64}/crosswalk-${VERSION}-64bit exists! -- OK"
    else
        echo "${PKG_TOOLS_LITE_DIR64}/crosswalk-${VERSION}-64bit does not exist! -- NOOOOOK!"
    fi
}

check_sdk_webview() {
    VERSION=$1
    arch=$2

    if [[ -d ${PKG_TOOLS_LITE_DIR}/crosswalk-webview-${VERSION}-${arch} ]]; then
        echo "${PKG_TOOLS_LITE_DIR}/crosswalk-webview-${VERSION}-${arch} exists! -- OK"
    else
        echo "${PKG_TOOLS_LITE_DIR}/crosswalk-webview-${VERSION}-${arch} does not exist! -- NOOOOOK!"
    fi
}

check_sdk_webview64() {
    VERSION=$1
    arch=$2

    if [[ -d ${PKG_TOOLS_LITE_DIR64}/crosswalk-webview-${VERSION}-${arch} ]]; then
        echo "${PKG_TOOLS_LITE_DIR64}/crosswalk-webview-${VERSION}-${arch} exists! -- OK"
    else
        echo "${PKG_TOOLS_LITE_DIR64}/crosswalk-webview-${VERSION}-${arch} does not exist! -- NOOOOOK!"
    fi
}

check_sdk_all() {
    VERSION=$1
    arch=$2

    if [[ -d ${PKG_TOOLS_LITE_DIR}/crosswalk-apks-${VERSION}-${arch} ]]; then
        echo "${PKG_TOOLS_LITE_DIR}/crosswalk-apks-${VERSION}-${arch} exists! -- OK"
    else
        echo "${PKG_TOOLS_LITE_DIR}/crosswalk-apks-${VERSION}-${arch} does not exist! -- NOOOOOK!"
    fi

    if [[ -d ${PKG_TOOLS_LITE_DIR}/crosswalk-cordova3-${VERSION}-${arch} ]]; then
        echo "${PKG_TOOLS_LITE_DIR}/crosswalk-cordova3-${VERSION}-${arch} exists! -- OK"
    else
        echo "${PKG_TOOLS_LITE_DIR}/crosswalk-cordova3-${VERSION}-${arch} does not exist! -- NOOOOOK!"
    fi

    if [[ -d ${PKG_TOOLS_LITE_DIR}/crosswalk-test-apks-${VERSION}-${arch} ]]; then
        echo "${PKG_TOOLS_LITE_DIR}/crosswalk-test-apks-${VERSION}-${arch} exists! -- OK"
    else
        echo "${PKG_TOOLS_LITE_DIR}/crosswalk-test-apks-${VERSION}-${arch} does not exist! -- NOOOOOK!"
    fi  

    if [[ -d ${PKG_TOOLS_LITE_DIR}/crosswalk-webview-${VERSION}-${arch} ]]; then
        echo "${PKG_TOOLS_LITE_DIR}/crosswalk-webview-${VERSION}-${arch} exists! -- OK"
    else
        echo "${PKG_TOOLS_LITE_DIR}/crosswalk-webview-${VERSION}-${arch} does not exist! -- NOOOOOK!"
    fi       
}

check_sdk_all64() {
    VERSION=$1
    arch=$2

    if [[ -d ${PKG_TOOLS_LITE_DIR64}/crosswalk-apks-${VERSION}-${arch} ]]; then
        echo "${PKG_TOOLS_LITE_DIR64}/crosswalk-apks-${VERSION}-${arch} exists! -- OK"
    else
        echo "${PKG_TOOLS_LITE_DIR64}/crosswalk-apks-${VERSION}-${arch} does not exist! -- NOOOOOK!"
    fi

    if [[ -d ${PKG_TOOLS_LITE_DIR64}/crosswalk-cordova3-${VERSION}-${arch} ]]; then
        echo "${PKG_TOOLS_LITE_DIR64}/crosswalk-cordova3-${VERSION}-${arch} exists! -- OK"
    else
        echo "${PKG_TOOLS_LITE_DIR64}/crosswalk-cordova3-${VERSION}-${arch} does not exist! -- NOOOOOK!"
    fi

    if [[ -d ${PKG_TOOLS_LITE_DIR64}/crosswalk-test-apks-${VERSION}-${arch} ]]; then
        echo "${PKG_TOOLS_LITE_DIR64}/crosswalk-test-apks-${VERSION}-${arch} exists! -- OK"
    else
        echo "${PKG_TOOLS_LITE_DIR64}/crosswalk-test-apks-${VERSION}-${arch} does not exist! -- NOOOOOK!"
    fi  

    if [[ -d ${PKG_TOOLS_LITE_DIR64}/crosswalk-webview-${VERSION}-${arch} ]]; then
        echo "${PKG_TOOLS_LITE_DIR64}/crosswalk-webview-${VERSION}-${arch} exists! -- OK"
    else
        echo "${PKG_TOOLS_LITE_DIR64}/crosswalk-webview-${VERSION}-${arch} does not exist! -- NOOOOOK!"
    fi       
}

check_sdk_for_apptools() {
    VERSION=$1

    if [ -f ${CROSSWALK_APP_TOOLS_LITE_CACHE_DIR}/crosswalk-${VERSION}.zip ]; then
        echo "${CROSSWALK_APP_TOOLS_LITE_CACHE_DIR}/crosswalk-${VERSION}.zip exists! -- OK"
    else
        echo "${CROSSWALK_APP_TOOLS_LITE_CACHE_DIR}/crosswalk-${VERSION}.zip does not exists -- NOOOOOK!"
    fi
}

check_sdk64_for_apptools() {
    VERSION=$1

    if [ -f ${CROSSWALK_APP_TOOLS_LITE_CACHE_DIR}/crosswalk-${VERSION}-64bit.zip ]; then
        echo "${CROSSWALK_APP_TOOLS_LITE_CACHE_DIR}/crosswalk-${VERSION}-64bit.zip exists! -- OK"
    else
        echo "${CROSSWALK_APP_TOOLS_LITE_CACHE_DIR}/crosswalk-${VERSION}-64bit.zip does not exists -- NOOOOOK!"
    fi
}

zero_text_file() {

    VERSION=$1
    echo "" > ${VERSION}_does_not_exist.txt
    echo "" > ${VERSION}_64_does_not_exist.txt
}


XWALK_VERSION=$1
check_sdk ${XWALK_VERSION}
check_sdk_all ${XWALK_VERSION} arm
check_sdk_all ${XWALK_VERSION} x86

check_sdk_for_apptools ${XWALK_VERSION}

