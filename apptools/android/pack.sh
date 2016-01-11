#!/bin/bash

#
#   This script will aim to pack all the apptools test suites related
#   for the Android platform. 
#   All the test suite names are listed in file pack_apptools_config.
#   Written by: Zhong Qiu
#   Date:       2015-11-24
#

PWD=$(pwd)
PWD_PARENT=$(dirname ${PWD})
VERSION_FILE=${PWD_PARENT}/VERSION

source ${VERSION_FILE}
source ${PWD}/config

DEST_DIR=${PWD}/${CROSSWALK_VERSION}-apptools

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

create_dest_dir() {
    if [ ! -d ${DEST_DIR} ]; then
        mkdir -pv ${DEST_DIR}/{embedded/{arm,x86,arm64,x86_64},shared/{arm,x86,arm64,x86_64}}
    fi    
}

init_env() {
    
    if [ ! -z ${UPDATE_CODE} ]; then
        update_cts ${CTS_DIR}        
    fi

    cd ${CTS_DIR}/tools
    rm -fr crosswalk
    if [ $1 = "32" ]; then
        cp -a ${CROSSWALK_DIR32}/crosswalk-${CROSSWALK_VERSION} ./crosswalk
    fi

    if [ $1 = "64" ]; then
       cp -a ${CROSSWALK_DIR64}/crosswalk-${CROSSWALK_VERSION}-64bit ./crosswalk 
    fi
    if [ ! -z ${USE_PATCH} ]; then
        sed -i 's|PKG_ARCHS = \["x86", "arm"\]|PKG_ARCHS = \["x86", "arm", "x86_64", "arm64"\]|g' ${CTS_DIR}/tools/build/pack.py
    fi

    cd -

    if [ ! -z ${UPDATE_XWALK_VERSION} ]; then
        update_xwalk_version ${CTS_DIR}
    fi
}

pack_apptools_tc32() {    

    for tc in ${APPTOOLS_TC_ANDROID}
    do        
        cd ${CTS_DIR}/${tc}
        rm -fv *.zip

        for mode in ${MODES}
        do
            for arch in ${ARCH32}
            do
                echo "../../tools/build/pack.py -t apk -m ${mode} -a ${arch}"
                ../../tools/build/pack.py -t apk -m ${mode} -a ${arch}
                if [ -f *.zip ]; then
                    mv -fv *.zip ${DEST_DIR}/${mode}/${arch}
                fi
            done
        done        
    done
}

pack_apptools_tc64() {    

    for tc in ${APPTOOLS_TC_ANDROID}
    do        
        cd ${CTS_DIR}/${tc}
        rm -fv *.zip

        for mode in ${MODES}
        do
            for arch in ${ARCH64}
            do
                echo "../../tools/build/pack.py -t apk -m ${mode} -a ${arch}"
                ../../tools/build/pack.py -t apk -m ${mode} -a ${arch}
                if [ -f *.zip ]; then
                    mv -fv *.zip ${DEST_DIR}/${mode}/${arch}
                fi
            done
        done        
    done
}

echo "################################################################################"
echo $(which crosswalk-app)
echo $(which crosswalk-pkg)
echo "################################################################################"
rm -fr ${DEST_DIR}
create_dest_dir
# init_env 32
pack_apptools_tc32
# init_env 64
pack_apptools_tc64
