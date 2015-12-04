#!/bin/bash

#
#   This script aims to pack the test suites involved to the Cordova
#   for compatibility tests.
#   
#   Written by: Zhong Qiu(zhongx.qiu@intel.com)
#   Date:       2015-11-25
#

CWD=$(pwd)
source ${PWD}/config

update_code() {

    if [[ $1 == "N" ]];then
        cd ${CWD}/crosswalk-test-suite
    elif [[ $1 == "N1" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N1}
    elif [[ $1 == "N2" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N2}
    elif [[ $1 == "N3" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N3}
    else
        echo "Params Error!"
        exit 1
    fi

    git reset --hard HEAD
    git pull
    
    cd -
}

update_version() {

    if [[ $1 == "N" ]];then
        cd ${CWD}/crosswalk-test-suite
    elif [[ $1 == "N1" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N1}
    elif [[ $1 == "N2" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N2}
    elif [[ $1 == "N3" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N3}
    fi 

    sed -i "s|\"main-version\": \"\([^\"]*\)\"|\"main-version\": \"$2\"|g" VERSION

    if [[ $1 == "N" ]]; then
        sed -i "s|beta|canary|g" VERSION
    elif [[ $1 == "N1" ]]; then
        echo "beta"
    else
        sed -i "s|beta|stable|g" VERSION
    fi
    cd -
}

copy_sdk() {

    if [[ $1 == "N" ]];then
        cd ${CWD}/crosswalk-test-suite/tools
    elif [[ $1 == "N1" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N1}/tools
    elif [[ $1 == "N2" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N2}/tools
    elif [[ $1 == "N3" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N3}/tools
    else
        echo "Params Error!"
        exit 1
    fi        

    rm -fr crosswalk
    if [[ -d ${PKG_TOOLS_DIR}/cordova_plugins_4.0 ]]; then
        cp -a ${PKG_TOOLS_DIR}/cordova_plugins_4.0 ./cordova_plugins
    else
        echo "${PKG_TOOLS_DIR}/crosswalk-$2 does not exists!"
        exit 1        
    fi
    cd -
}

modify_gradle() {

    if [[ $1 == "N" ]]; then
        cd ${CWD}/crosswalk-test-suite/tools/cordova_plugins/cordova-plugin-crosswalk-webview
        git reset --hard HEAD
        git checkout 
    elif [[ $1 == "N1" ]]; then
        cd         
    fi

    cd -
}