#!/bin/bash

#
# Check whether the zip package is packed successfully
#

CWD=$(pwd)
source ${CWD}/config

OFFICIAL_DEST_DIR="/data/TestSuites_Storage/live/android"

CORDOVA_SAMPLEAPP_LIST="mobilespec
helloworld
remotedebugging
spacedodge
statusbar
renamePkg
xwalkCommandLine
setBackgroundColor
privateNotes
"

check_cordova_tc() {
    BRANCH=$1
    VERSION=$2
    mode=$3
    arch=$4


    for cordova_tc in ${CORDOVA_SAMPLE_APPS_TC}
    do        
        tc_name=$(echo ${cordova_tc} | awk -F '/' '{print $2}')
        zip_name=${OFFICIAL_DEST_DIR}/${BRANCH}/${VERSION}/cordova4.x-${mode}/${arch}/${tc_name}-${VERSION}-1.cordova.zip        
        if [ -f ${zip_name} ]; then
            # echo "${zip_name} exists!"
            echo ""
        else
            echo "${zip_name} does not exist!"
        fi
    done

    for cordova_tc in ${USECASE_CORDOVA}
    do
        zip_name=${OFFICIAL_DEST_DIR}/${BRANCH}/${VERSION}/cordova4.x-${mode}/${arch}/${tc_name}-${VERSION}-1.cordova.zip
        if [ -f ${zip_name} ]; then
            # echo "${zip_name} exists!"
            echo ""
        else
            echo "${zip_name} does not exist!"
        fi
    done    

}

check_cordova_apks() {
    BRANCH=$1
    VERSION=$2
    mode=$3
    arch=$4

    for tc_name in ${CORDOVA_SAMPLEAPP_LIST}
    do        
        zip_name=${OFFICIAL_DEST_DIR}/${BRANCH}/${VERSION}/cordova4.x-${mode}/${arch}/${tc_name}.apk
        if [ -f ${zip_name} ]; then
            echo ""
        else
            echo "${zip_name} does not exist!"
        fi
    done
}


# check_cordova_tc master 18.46.453.0 embedded arm
# check_cordova_tc master 18.46.453.0 shared arm

check_cordova_apks master 18.46.453.0 embedded arm
check_cordova_apks master 18.46.453.0 shared arm