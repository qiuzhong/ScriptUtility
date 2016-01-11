#!/bin/bash

PREFIX_DIR="/home/orange/00_jiajia/images/linux-ftp.sh.intel.com/pub/mirrors/01org/crosswalk/releases/crosswalk/android"

# CROSSWALK_APP_TOOLS_CACHE_DIR is an environment variable. 
# Set in ~/.bashrc
PREFIX_PKG_TOOLS_ZIP=${CROSSWALK_APP_TOOLS_CACHE_DIR}

copy_sdk_4apptools() {

    VERSION=$1
    BRANCH=$2

    if [[ ! -d ${PREFIX_PKG_TOOLS_ZIP}/crosswalk-${VERSION}.zip ]]; then
        cp -fv ${PREFIX_DIR}/${BRANCH}/${VERSION}/crosswalk-${VERSION}.zip ${PREFIX_PKG_TOOLS_ZIP}
    else
        echo "${PREFIX_PKG_TOOLS_ZIP}/crosswalk-${VERSION}.zip already exists!"
    fi
}

copy_sdk_4apptools64() {

    VERSION=$1
    BRANCH=$2

    if [[ ! -d ${PREFIX_PKG_TOOLS_ZIP}/crosswalk-${VERSION}-64bit.zip ]]; then
        cp -fv ${PREFIX_DIR}/${BRANCH}/${VERSION}/crosswalk-${VERSION}-64bit.zip ${PREFIX_PKG_TOOLS_ZIP}
    else
        echo "${PREFIX_PKG_TOOLS_ZIP}/crosswalk-${VERSION}-64bit.zip already exists!"
    fi
}

# copy_sdk_4apptools 17.46.448.1 beta
# copy_sdk_4apptools64 17.46.448.1 beta
# copy_sdk_4apptools 17.46.448.0 canary
# copy_sdk_4apptools64 17.46.448.0 canary
copy_sdk_4apptools 16.45.421.19 beta