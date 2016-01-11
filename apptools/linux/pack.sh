#!/bin/bash

#
#   This script will aim to pack all the apptools test suites related
#   for the Linux platform. 
#   All the test suite names are listed in file pack_apptools_config.
#   Written by: Zhong Qiu
#   Date:       2015-11-24
#

PWD=$(pwd)
PWD_PARENT=$(dirname ${PWD})
#echo ${PWD_PARENT}
VERSION_FILE=${PWD_PARENT}/VERSION
#echo ${VERSION_FILE}

source ${VERSION_FILE}
source ${PWD}/config

DEST_DIR=${PWD}/${CROSSWALK_VERSION}-apptools
PATCH_PACK_DEB_PY=${PATCH_DIR}/build_deb.py

update_cts() {
    cd $1
    git reset --hard HEAD
    git checkout master
    git pull
    cd -
}

update_xwalk_version() {
    cd $1
    sed -i "s|\"main-version\": \"\([^\"]*\)\"|\"main-version\": \"${CROSSWALK_VERSION}\"|g" VERSION
    cd -
}

init_env() {
    if [ ! -d ${DEST_DIR} ]; then
        mkdir ${DEST_DIR}
    fi

    if [ ${UPDATE_CODE} == "Yes" ]; then
        update_cts ${CTS_DIR}
    fi

    if [ ${USE_PATCH} == "Yes" ]; then
        cp -fv ${PATCH_PACK_DEB_PY} ${CTS_DIR}/tools/build/
    fi

    if [  ${UPDATE_XWALK_VERSION} == "Yes" ]; then
        update_xwalk_version ${CTS_DIR}
    fi
}

pack_apptools_tc() {

    for tc in ${APPTOOLS_TC_LINUX}
    do
        cd ${CTS_DIR}/${tc}
        rm -fv *.zip
        ../../tools/build/pack.py -t deb
        mv -fv *.zip ${DEST_DIR}
    done
}

echo "################################################################################"
echo $(which crosswalk-app)
echo $(which crosswalk-pkg)
echo "################################################################################"

init_env
pack_apptools_tc
