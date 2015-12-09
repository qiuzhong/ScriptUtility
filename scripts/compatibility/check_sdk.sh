#!/bin/bash

#
# Check whether the SDK exist
#

CWD=$(pwd)
source ${PWD}/config


check_sdk() {
    VERSION=$1

    if [[ -d ${PKG_TOOLS_DIR}/crosswalk-${VERSION} ]]; then
        echo "${PKG_TOOLS_DIR}/crosswalk-${VERSION} exists! -- OK"
    else
        echo "${PKG_TOOLS_DIR}/crosswalk-${VERSION} does not exist! -- NOOOOOK!"
        echo "crosswalk-${VERSION}" >> ${VERSION}_does_not_exist.txt
    fi
}

check_sdk64() {
    VERSION=$1

    if [[ -d ${PKG_TOOLS_DIR64}/crosswalk-${VERSION}-64bit ]]; then
        echo "${PKG_TOOLS_DIR64}/crosswalk-${VERSION}-64bit exists! -- OK"
    else
        echo "${PKG_TOOLS_DIR64}/crosswalk-${VERSION}-64bit does not exist! -- NOOOOOK!"
        echo "crosswalk-${VERSION}" >> ${VERSION}_64_does_not_exist.txt
    fi
}

check_sdk_webview() {
    VERSION=$1
    arch=$2

    if [[ -d ${PKG_TOOLS_DIR}/crosswalk-webview-${VERSION}-${arch} ]]; then
        echo "${PKG_TOOLS_DIR}/crosswalk-webview-${VERSION}-${arch} exists! -- OK"
    else
        echo "${PKG_TOOLS_DIR}/crosswalk-webview-${VERSION}-${arch} does not exist! -- NOOOOOK!"
        echo "crosswalk-webview-${VERSION}-${arch}" >> ${VERSION}_does_not_exist.txt
    fi
}

check_sdk_webview64() {
    VERSION=$1
    arch=$2

    if [[ -d ${PKG_TOOLS_DIR64}/crosswalk-webview-${VERSION}-${arch} ]]; then
        echo "${PKG_TOOLS_DIR64}/crosswalk-webview-${VERSION}-${arch} exists! -- OK"
    else
        echo "${PKG_TOOLS_DIR64}/crosswalk-webview-${VERSION}-${arch} does not exist! -- NOOOOOK!"
        echo "crosswalk-webview-${VERSION}-${arch}" >> ${VERSION}_64_does_not_exist.txt
    fi
}

check_sdk_all() {
    VERSION=$1
    arch=$2

    if [[ -d ${PKG_TOOLS_DIR}/crosswalk-apks-${VERSION}-${arch} ]]; then
        echo "${PKG_TOOLS_DIR}/crosswalk-apks-${VERSION}-${arch} exists! -- OK"
    else
        echo "${PKG_TOOLS_DIR}/crosswalk-apks-${VERSION}-${arch} does not exist! -- NOOOOOK!"
        echo "crosswalk-apks-${VERSION}-${arch}" >> ${VERSION}_does_not_exist.txt
    fi

    if [[ -d ${PKG_TOOLS_DIR}/crosswalk-cordova3-${VERSION}-${arch} ]]; then
        echo "${PKG_TOOLS_DIR}/crosswalk-cordova3-${VERSION}-${arch} exists! -- OK"
    else
        echo "${PKG_TOOLS_DIR}/crosswalk-cordova3-${VERSION}-${arch} does not exist! -- NOOOOOK!"
        echo "crosswalk-cordova3-${VERSION}-${arch}" >> ${VERSION}_does_not_exist.txt
    fi

    if [[ -d ${PKG_TOOLS_DIR}/crosswalk-test-apks-${VERSION}-${arch} ]]; then
        echo "${PKG_TOOLS_DIR}/crosswalk-test-apks-${VERSION}-${arch} exists! -- OK"
    else
        echo "${PKG_TOOLS_DIR}/crosswalk-test-apks-${VERSION}-${arch} does not exist! -- NOOOOOK!"
        echo "crosswalk-test-apks-${VERSION}-${arch}" >> ${VERSION}_does_not_exist.txt
    fi  

    if [[ -d ${PKG_TOOLS_DIR}/crosswalk-webview-${VERSION}-${arch} ]]; then
        echo "${PKG_TOOLS_DIR}/crosswalk-webview-${VERSION}-${arch} exists! -- OK"
    else
        echo "${PKG_TOOLS_DIR}/crosswalk-webview-${VERSION}-${arch} does not exist! -- NOOOOOK!"
        echo "crosswalk-webview-${VERSION}-${arch}" >> ${VERSION}_does_not_exist.txt
    fi       
}

check_sdk_all64() {
    VERSION=$1
    arch=$2

    if [[ -d ${PKG_TOOLS_DIR64}/crosswalk-apks-${VERSION}-${arch} ]]; then
        echo "${PKG_TOOLS_DIR64}/crosswalk-apks-${VERSION}-${arch} exists! -- OK"
    else
        echo "${PKG_TOOLS_DIR64}/crosswalk-apks-${VERSION}-${arch} does not exist! -- NOOOOOK!"
        echo "crosswalk-test-apks-${VERSION}-${arch}" >> ${VERSION}_64_does_not_exist.txt
    fi

    if [[ -d ${PKG_TOOLS_DIR64}/crosswalk-cordova3-${VERSION}-${arch} ]]; then
        echo "${PKG_TOOLS_DIR64}/crosswalk-cordova3-${VERSION}-${arch} exists! -- OK"
    else
        echo "${PKG_TOOLS_DIR64}/crosswalk-cordova3-${VERSION}-${arch} does not exist! -- NOOOOOK!"
        echo "crosswalk-cordova3-${VERSION}-${arch}" >> ${VERSION}_64_does_not_exist.txt
    fi

    if [[ -d ${PKG_TOOLS_DIR64}/crosswalk-test-apks-${VERSION}-${arch} ]]; then
        echo "${PKG_TOOLS_DIR64}/crosswalk-test-apks-${VERSION}-${arch} exists! -- OK"
    else
        echo "${PKG_TOOLS_DIR64}/crosswalk-test-apks-${VERSION}-${arch} does not exist! -- NOOOOOK!"
        echo "crosswalk-test-apks-${VERSION}-${arch}" >> ${VERSION}_64_does_not_exist.txt
    fi  

    if [[ -d ${PKG_TOOLS_DIR64}/crosswalk-webview-${VERSION}-${arch} ]]; then
        echo "${PKG_TOOLS_DIR64}/crosswalk-webview-${VERSION}-${arch} exists! -- OK"
    else
        echo "${PKG_TOOLS_DIR64}/crosswalk-webview-${VERSION}-${arch} does not exist! -- NOOOOOK!"
        echo "crosswalk-webview-${VERSION}-${arch}" >> ${VERSION}_64_does_not_exist.txt
    fi       
}

zero_text_file() {

    VERSION=$1
    echo "" > ${VERSION}_does_not_exist.txt
    echo "" > ${VERSION}_64_does_not_exist.txt
}

# check_sdk ${N_VER}
# check_sdk ${N_1_VER}
# check_sdk ${N_2_VER}
# check_sdk ${N_3_VER}

# check_sdk_webview ${N_VER} arm
# check_sdk_webview ${N_VER} x86
# check_sdk_webview ${N_1_VER} arm
# check_sdk_webview ${N_1_VER} x86
# check_sdk_webview ${N_2_VER} arm
# check_sdk_webview ${N_2_VER} x86
# check_sdk_webview ${N_2_VER} arm
# check_sdk_webview ${N_2_VER} x86
# check_sdk_webview ${N_3_VER} arm
# check_sdk_webview ${N_3_VER} x86

# check_sdk_all ${N_VER} arm
# check_sdk_all ${N_VER} x86

# check_sdk_all ${N_1_VER} arm
# check_sdk_all ${N_1_VER} x86

# check_sdk_all ${N_2_VER} arm
# check_sdk_all ${N_2_VER} x86

# check_sdk_all ${N_3_VER} arm
# check_sdk_all ${N_3_VER} x86


zero_text_file 17.46.448.2

check_sdk 17.46.448.2
check_sdk_all 17.46.448.2 arm
check_sdk_all 17.46.448.2 x86

check_sdk64 17.46.448.2
check_sdk_all64 17.46.448.2 arm64
check_sdk_all64 17.46.448.2 x86_64