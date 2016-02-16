#!/bin/bash


PREFIX_DIR="/home/orange/00_jiajia/images/linux-ftp.sh.intel.com/pub/mirrors/01org/crosswalk/releases/crosswalk/android"
PREFIX_URL="https://linux-ftp.sh.intel.com/pub/mirrors/01org/crosswalk/releases/crosswalk/android"
PKG_TOOLS_DIR="/data/jiaxxx_shared/pkg_tools"
PKG_TOOLS_DIR64="/data/jiaxxx_shared/pkg_tools_64"
XWALK_ZIP_DIR="/home/orange/pkg_tools_zip"

download_xwalk_sdk_arch() {
    VERSION=$1
    BRANCH=$2
    arch=$3

    if [ ! -d ${PREFIX_DIR}/${BRANCH}/${VERSION}/${arch} ]; then
        mkdir -pv ${PREFIX_DIR}/${BRANCH}/${VERSION}/${arch}
    fi
    cd ${PREFIX_DIR}/${BRANCH}/${VERSION}/${arch}
    if [[ ! -f crosswalk-apks-${VERSION}-${arch}.zip ]]; then
        wget --no-proxy --no-check-certificate ${PREFIX_URL}/${BRANCH}/${VERSION}/${arch}/crosswalk-apks-${VERSION}-${arch}.zip 
    else
        echo "${PREFIX_DIR}/${BRANCH}/${VERSION}/${arch}/crosswalk-apks-${VERSION}-${arch}.zip already exists!"
    fi

    # if [[ ! -f crosswalk-cordova3-${VERSION}-${arch}.zip ]]; then
    #     wget --no-proxy --no-check-certificate ${PREFIX_URL}/${BRANCH}/${VERSION}/${arch}/crosswalk-cordova3-${VERSION}-${arch}.zip
    # else
    #     echo "${PREFIX_DIR}/${BRANCH}/${VERSION}/${arch}/crosswalk-cordova3-${VERSION}-${arch}.zip already exists!"
    # fi

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

download_xwalk_sdk_arch_single() {
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

unzip_xwalk_sdk_arch() {
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

    # if [[ -f crosswalk-cordova3-${VERSION}-${arch}.zip ]]; then
    #     unzip crosswalk-cordova3-${VERSION}-${arch}.zip -d ${DEST_DIR}
    # else
    #     echo "${PREFIX_DIR}/${BRANCH}/${VERSION}/${arch}/crosswalk-cordova3-${VERSION}-${arch}.zip already exists!"
    # fi

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

unzip_xwalk_sdk_arch_single() {
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

download_xwalk_zip_aar() {
    VERSION=$1
    BRANCH=$2

    cd ${PREFIX_DIR}/${BRANCH}/${VERSION}
    if [[ ! -f crosswalk-${VERSION}.zip ]]; then
        wget --no-proxy --no-check-certificate ${PREFIX_URL}/${BRANCH}/${VERSION}/crosswalk-${VERSION}.zip
    else
        echo "${PREFIX_DIR}/${BRANCH}/${VERSION}/${arch}/crosswalk-${VERSION}.zip already exists!"
    fi

    if [[ ! -f crosswalk-${VERSION}.aar ]]; then
        wget --no-proxy --no-check-certificate ${PREFIX_URL}/${BRANCH}/${VERSION}/crosswalk-${VERSION}.aar
    else
        echo "${PREFIX_DIR}/${BRANCH}/${VERSION}/crosswalk-${VERSION}.aar already exists!"
    fi

    if [[ ! -f crosswalk-${VERSION}-64bit.zip ]]; then
        wget --no-proxy --no-check-certificate ${PREFIX_URL}/${BRANCH}/${VERSION}/crosswalk-${VERSION}-64bit.zip
    else
        echo "${PREFIX_DIR}/${BRANCH}/${VERSION}/${arch}/crosswalk-${VERSION}-64bit.zip already exists!"
    fi

    if [[ ! -f crosswalk-${VERSION}-64bit.aar ]]; then
        wget --no-proxy --no-check-certificate ${PREFIX_URL}/${BRANCH}/${VERSION}/crosswalk-${VERSION}-64bit.aar
    else
        echo "${PREFIX_DIR}/${BRANCH}/${VERSION}/crosswalk-${VERSION}-64bit.aar already exists!"
    fi

    if [[ ! -f crosswalk-shared-${VERSION}.aar ]]; then
        wget --no-proxy --no-check-certificate ${PREFIX_URL}/${BRANCH}/${VERSION}/crosswalk-shared-${VERSION}.aar
    else
        echo "${PREFIX_DIR}/${BRANCH}/${VERSION}/crosswalk-shared-${VERSION}.aar already exists!"
    fi      
}

copy_zip_aar() {
    VERSION=$1
    BRANCH=$2

    cd ${PREFIX_DIR}/${BRANCH}/${VERSION}
    cp -fv crosswalk-${VERSION}.zip ${XWALK_ZIP_DIR}
    cp -fv crosswalk-${VERSION}-64bit.zip ${XWALK_ZIP_DIR}
            
    cp -fv crosswalk-${VERSION}.aar ${PKG_TOOLS_DIR}
    cp -fv crosswalk-shared-${VERSION}.aar ${PKG_TOOLS_DIR}


    cp -fv crosswalk-${VERSION}-64bit.aar ${PKG_TOOLS_DIR64}

}

unzip_xwalk_zip() {
    VERSION=$1
    BRANCH=$2

    cd ${PREFIX_DIR}/${BRANCH}/${VERSION}
    unzip crosswalk-${VERSION}.zip -d ${PKG_TOOLS_DIR}
    unzip crosswalk-${VERSION}-64bit.zip -d ${PKG_TOOLS_DIR64}
}

# $1 -- xwalk version
# $2 -- branch: canary/beta/stable

download_xwalk_sdk_arch $1 $2 arm
download_xwalk_sdk_arch $1 $2 x86
download_xwalk_sdk_arch $1 $2 arm64
download_xwalk_sdk_arch $1 $2 x86_64
download_xwalk_zip_aar $1 $2

unzip_xwalk_sdk_arch $1 $2 arm ${PKG_TOOLS_DIR}
unzip_xwalk_sdk_arch $1 $2 x86 ${PKG_TOOLS_DIR}
unzip_xwalk_sdk_arch $1 $2 arm64 ${PKG_TOOLS_DIR64}
unzip_xwalk_sdk_arch $1 $2 x86_64 ${PKG_TOOLS_DIR64}

copy_zip_aar $1 $2
unzip_xwalk_zip $1 $2

# download_xwalk_sdk_single 17.46.448.2 beta arm64 crosswalk-webview
# unzip_xwalk_sdk_single 17.46.448.2 beta arm64 crosswalk-webview ${PKG_TOOLS_DIR64}

