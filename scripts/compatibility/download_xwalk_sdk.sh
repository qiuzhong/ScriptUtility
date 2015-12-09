#!/bin/bash


PREFIX_DIR="/home/orange/00_jiajia/images/linux-ftp.sh.intel.com/pub/mirrors/01org/crosswalk/releases/crosswalk/android"
PREFIX_URL="https://linux-ftp.sh.intel.com/pub/mirrors/01org/crosswalk/releases/crosswalk/android"
PKG_TOOLS_DIR="/data/jiaxxx_shared/pkg_tools"
PKG_TOOLS_DIR64="/data/jiaxxx_shared/pkg_tools_64"

download_xwalk_sdk() {
    VERSION=$1
    BRANCH=$2
    arch=$3

    cd ${PREFIX_DIR}/${BRANCH}/${VERSION}/${arch}
    if [[ ! -f crosswalk-apks-${VERSION}-${arch}.zip ]]; then
        wget --no-proxy --no-check-certificate ${PREFIX_URL}/${BRANCH}/${VERSION}/${arch}/crosswalk-apks-${VERSION}-${arch}.zip 
    else
        echo "${PREFIX_DIR}/${BRANCH}/${VERSION}/${arch}/crosswalk-apks-${VERSION}-${arch}.zip already exists!"
    fi

    if [[ ! -f crosswalk-cordova3-${VERSION}-${arch}.zip ]]; then
        wget --no-proxy --no-check-certificate ${PREFIX_URL}/${BRANCH}/${VERSION}/${arch}/crosswalk-cordova3-${VERSION}-${arch}.zip
    else
        echo "${PREFIX_DIR}/${BRANCH}/${VERSION}/${arch}/crosswalk-cordova3-${VERSION}-${arch}.zip already exists!"
    fi

    if [[ ! -f crosswalk-test-apks-${VERSION}-${arch}.zip ]]; then
        wget --no-proxy --no-check-certificate ${PREFIX_URL}/${BRANCH}/${VERSION}/${arch}/crosswalk-test-apks-${VERSION}-${arch}.zip
    else
        echo "${PREFIX_DIR}/${BRANCH}/${VERSION}/${arch}/crosswalk-test-apks-${VERSION}-${arch}.zip already exists!"
    fi

    if [[ ! -f crosswalk-webview-${VERSION}-${arch}.zip ]]; then
        wget --no-proxy --no-check-certificate ${PREFIX_URL}/${BRANCH}/${VERSION}/${arch}/crosswalk-webview-${VERSION}-${arch}.zip
    else
        echo "${PREFIX_DIR}/${BRANCH}/${VERSION}/${arch}/crosswalk-webview-${VERSION}-${arch}.zip already exists!"
    fi        
}

download_xwalk_sdk_single() {
    VERSION=$1
    BRANCH=$2
    arch=$3
    single_sdk_zip=$4

    cd ${PREFIX_DIR}/${BRANCH}/${VERSION}/${arch}

    if [[ ! -f ${single_sdk_zip}-${VERSION}-${arch}.zip ]]; then
        wget --no-proxy --no-check-certificate ${PREFIX_URL}/${BRANCH}/${VERSION}/${arch}/${single_sdk_zip}-${VERSION}-${arch}.zip
    else
        echo "${PREFIX_DIR}/${BRANCH}/${VERSION}/${arch}/${single_sdk_zip}-${VERSION}-${arch}.zip already exists!"
    fi  
}

unzip_xwalk_sdk() {
    VERSION=$1
    BRANCH=$2
    arch=$3
    DEST_DIR=$4

    cd ${PREFIX_DIR}/${BRANCH}/${VERSION}/${arch}
    if [[ -f crosswalk-apks-${VERSION}-${arch}.zip ]]; then
        unzip crosswalk-apks-${VERSION}-${arch}.zip -d ${DEST_DIR}
    else
        echo "crosswalk-apks-${VERSION}-${arch}.zip does not exist!"
    fi

    if [[ -f crosswalk-cordova3-${VERSION}-${arch}.zip ]]; then
        unzip crosswalk-cordova3-${VERSION}-${arch}.zip -d ${DEST_DIR}
    else
        echo "${PREFIX_DIR}/${BRANCH}/${VERSION}/${arch}/crosswalk-cordova3-${VERSION}-${arch}.zip already exists!"
    fi

    if [[ -f crosswalk-test-apks-${VERSION}-${arch}.zip ]]; then
        unzip crosswalk-test-apks-${VERSION}-${arch}.zip -d ${DEST_DIR}
    else
        echo "crosswalk-test-apks-${VERSION}-${arch}.zip already exists!"
    fi

    if [[ -f crosswalk-webview-${VERSION}-${arch}.zip ]]; then
        unzip crosswalk-webview-${VERSION}-${arch}.zip -d  ${DEST_DIR}
    else
        echo "crosswalk-webview-${VERSION}-${arch}.zip already exists!"
    fi   
}

unzip_xwalk_sdk_single() {
    VERSION=$1
    BRANCH=$2
    arch=$3    
    single_sdk_zip=$4
    DEST_DIR=$5

    cd ${PREFIX_DIR}/${BRANCH}/${VERSION}/${arch}

    if [[ -f ${single_sdk_zip}-${VERSION}-${arch}.zip ]]; then
        unzip ${single_sdk_zip}-${VERSION}-${arch}.zip -d  ${DEST_DIR}
    else
        echo "${single_sdk_zip}-${VERSION}-${arch}.zip already exists!"
    fi   
}


# download_xwalk_sdk 17.46.448.2 beta x86
# download_xwalk_sdk 17.46.448.2 beta x86_64

# unzip_xwalk_sdk 17.46.448.2 beta x86 ${PKG_TOOLS_DIR}
# unzip_xwalk_sdk 17.46.448.2 beta x86_64 ${PKG_TOOLS_DIR64}

download_xwalk_sdk_single 17.46.448.2 beta arm64 crosswalk-webview
unzip_xwalk_sdk_single 17.46.448.2 beta arm64 crosswalk-webview ${PKG_TOOLS_DIR64}