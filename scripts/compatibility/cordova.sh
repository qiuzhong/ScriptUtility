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

    DIR_NAME=$1    
    if [[ ${DIR_NAME} == "N" ]];then
        cd ${CWD}/crosswalk-test-suite
    elif [[ ${DIR_NAME} == "N1" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N1}
    elif [[ ${DIR_NAME} == "N2" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N2}
    elif [[ ${DIR_NAME} == "N3" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N3}
    else
        echo "Params Error!"
        exit 1
    fi

    git reset --hard HEAD
    git pull
    
    cd -
}

copy_sampleapp_code() {

    DIR_NAME=$1
    if [[ ${DIR_NAME} == "N" ]];then
        cd ${CWD}/crosswalk-test-suite/tools/
    elif [[ ${DIR_NAME} == "N1" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N1}/tools
    elif [[ ${DIR_NAME} == "N2" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N2}/tools
    elif [[ ${DIR_NAME} == "N3" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N3}/tools
    else
        echo "Params Error!"
        exit 1
    fi

    if [[ ! -d circ ]]; then
        git clone ${CORDOVA_CIRC_URL}
    fi

    if [[ ! -d workshop-cca-eh ]]; then
        git clone ${CORDOVA_EH_URL}
    fi

    if [[ ! -d mobilespec ]]; then
        mkdir -pv mobilespec/
        cd mobilespec
        git clone ${CORDOVA_MOBILESPEC_URL}
    fi

}

update_version() {

    DIR_NAME=$1
    if [[ ${DIR_NAME} == "N" ]];then
        cd ${CWD}/crosswalk-test-suite
    elif [[ ${DIR_NAME} == "N1" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N1}
    elif [[ ${DIR_NAME} == "N2" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N2}
    elif [[ ${DIR_NAME} == "N3" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N3}
    fi 

    sed -i "s|\"main-version\": \"\([^\"]*\)\"|\"main-version\": \"$2\"|g" VERSION

    if [[ ${DIR_NAME} == "N" ]]; then
        sed -i "s|beta|canary|g" VERSION
    elif [[ ${DIR_NAME} == "N1" ]]; then
        echo "beta"
    else
        sed -i "s|beta|stable|g" VERSION
    fi

    cd -
}

copy_cordova_plugin() {

    DIR_NAME=$1

    if [[ ${DIR_NAME} == "N" ]];then
        cd ${CWD}/crosswalk-test-suite/tools
    elif [[ ${DIR_NAME} == "N1" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N1}/tools
    elif [[ ${DIR_NAME} == "N2" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N2}/tools
    elif [[ ${DIR_NAME} == "N3" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N3}/tools
    else
        echo "Params Error!"
        exit 1
    fi

    if [[ ! -d cordova_plugins ]]; then
        if [[ -d ${PKG_TOOLS_DIR}/cordova_plugins_4.0 ]]; then
            cp -a ${PKG_TOOLS_DIR}/cordova_plugins_4.0 ./cordova_plugins
        else
            echo "${PKG_TOOLS_DIR}/crosswalk-plugins_4.0 does not exists!"
            exit 1        
        fi
    fi
}

update_cordova_plugin() {
    DIR_NAME=$1
    CORDOVA_PLUGIN_XWALK_WEBVIEW_BRANCH=$2

    if [[ ${DIR_NAME} == "N" ]];then
        cd ${CWD}/crosswalk-test-suite/tools
    elif [[ ${DIR_NAME} == "N1" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N1}/tools
    elif [[ ${DIR_NAME} == "N2" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N2}/tools
    elif [[ ${DIR_NAME} == "N3" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N3}/tools
    else
        echo "Params Error!"
        exit 1
    fi

    cd cordova_plugins/cordova-plugin-crosswalk-webview
    git reset --hard HEAD
    git pull
    git checkout ${CORDOVA_PLUGIN_XWALK_WEBVIEW_BRANCH}

    cd ${CWD}
}

modify_gradle() {

    BRANCH=$2
    if [[ ${BRANCH} == "master" ]]; then
        cd cordova_plugins/cordova-plugin-crosswalk-webview
        git checkout -- ${GRADLE}
        begin_line=`sed -n '/  maven {/=' ${GRADLE}`
        end_line=$[$begin_line + 2]
        sed -i "${begin_line},${end_line}d" ${GRADLE}
        sed -i "${begin_line}i\  mavenLocal()" ${GRADLE}       
    fi    
}

modify_gradle_4cca() {

    DIR_NAME=$1
    BRANCH=$2
    CROSSWALK_VERSION=$3
    mode=$4

    if [[ ${DIR_NAME} == "N" ]];then
        cd ${CWD}/crosswalk-test-suite/tools
    elif [[ ${DIR_NAME} == "N1" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N1}/tools
    elif [[ ${DIR_NAME} == "N2" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N2}/tools
    elif [[ ${DIR_NAME} == "N3" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N3}/tools
    else
        echo "Params Error!"
        exit 1
    fi

    cd cordova_plugins/cordova-plugin-crosswalk-webview
    git checkout -- ${GRADLE}
    if [[ ${BRANCH} == "master" ]]; then
        begin_line=`sed -n '/  maven {/=' ${GRADLE}`
        end_line=$[$begin_line + 2]
        sed -i "${begin_line},${end_line}d" ${GRADLE}
        sed -i "${begin_line}i\  mavenLocal()" ${GRADLE}        
        sed -i "s|ext.xwalkVersion = getConfigPreference(\"xwalkVersion\")|ext.xwalkVersion = \"${CROSSWALK_VERSION}\"|g" ${GRADLE}
    fi

    if [[ ${BRANCH} == "beta" ]]; then
        if [[ ${mode} == "shared" ]]; then
            sed -i "s|ext.xwalkVersion = getConfigPreference(\"xwalkVersion\")|ext.xwalkVersion = \"org.xwalk:xwalk_core_library_beta:${CROSSWALK_VERSION}\"|g" ${GRADLE}
        elif [[ ${mode} == "embedded" ]]; then
            sed -i "s|ext.xwalkVersion = getConfigPreference(\"xwalkVersion\")|ext.xwalkVersion = \"org.xwalk:xwalk_shared_library_beta:${CROSSWALK_VERSION}\"|g" ${GRADLE}
        else
            echo "Wrong mode!"
            exit 1
        fi
    fi
}

update_cordova_tc() {
    DIR_NAME=$1
    BRANCH=$2
    arch=$3
    mode=$4
    tag=$5

    if [[ ${DIR_NAME} == "N" ]];then
        cd ${CWD}/crosswalk-test-suite
    elif [[ ${DIR_NAME} == "N1" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N1}
    elif [[ ${DIR_NAME} == "N2" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N2}
    elif [[ ${DIR_NAME} == "N3" ]]; then
        cd ${CWD}/crosswalk-test-suite-${N3}
    else
        echo "Params Error!"
        exit 1
    fi

    for tc in ${CORDOVA_SAMPLE_APPS_TC}
    do
        ../../tools/build/pack.py -t cordova --sub-version 4.x -a ${arch} -m ${mode}
        tc_name=$(echo $tc | awk -F '/' '{print $2}')
        mv -fv *.zip ${tc_name}-${DIR_NAME}.${DIR_NAME}-${tag}-${mode}.cordova.zip
        mv -fv ${tc_name}-${DIR_NAME}.${DIR_NAME}-${tag}-${mode}.cordova.zip ${DEST_DIR}/testsuites/cordova/crosswalk-${DIR_NAME}/${arch}
    done
}


###############################################################################
#   Building Cordova-related apks and test suites.
#   
###############################################################################

update_code N2