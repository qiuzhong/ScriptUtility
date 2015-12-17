#!/bin/bash

################################################################################
#
#   This script aims to pack the Crosswalk sample apks.
#   Pre-condition:
#       1. In a workspace directory, clone the following repositories:
#           https://github.com/crosswalk-project/crosswalk-demos.git
#           https://github.com/crosswalk-project/crosswalk-samples.git
#       2. Rename the directory crosswalk-samples to crosswalk-samples-original
#       3. Copy HexGL and inst.py to the workspace directory
#       4. Copy patch to the workspace directory
#       5. Modify the config file. Set OFFICIAL_RELEASE_FLAG="true" if use it
#           in product environment.
#       6. Makre sure crosswalk-appt-tools is available and 
#           crosswalk-<Version>-64bit.zip is in ${CROSSWALK_APP_TOOLS_CACHE_DIR}
#   Usage:
#       ./pack_xwalk_samples64.sh -v <Crosswalk Version> -r
#
################################################################################ 

CWD=$(pwd)
source /etc/profile
source ${CWD}/config

if [ ${OFFICIAL_RELEASE_FLAG} == "true" ]; then
    ROOT_DIR=${OFFICIAL_ROOT_DIR}
    DEST_BINARY_DIR=${OFFICIAL_DEST_BINARY_DIR}
else
    ROOT_DIR=${TEST_ROOT_DIR}
    DEST_BINARY_DIR=${TEST_DEST_BINARY_DIR}
fi

PATCH_DIR64=${ROOT_DIR}/patch/64bit

PKG_TOOLS_DIR=${CROSSWALK_APP_TOOLS_CACHE_DIR}
CROSSWALK_PKG=$PKG_TOOLS_DIR/crosswalk-app-tools/src/crosswalk-pkg


SDK_VERSION=""
RELEASE_FLAG=0
MODE="embedded"
ARCH="x86"


show_help() {
    usage="Usage: ./sampleApp_pack.sh -v <sdk_version> -r
        -v <sdk_version> use <sdk_version> to  pack apk only,
        -r it will not only pack apk but also comparess and pack sourcecode for release !!!"

    echo $usage    
}

show_params() {
    echo "################################################################################"
    echo "Workspace directory: ${ROOT_DIR}"
    echo "Samples apps binary directory: ${DEST_BINARY_DIR}"
    echo "Crosswalk Version: ${SDK_VERSION}"
    echo "Default mode: ${MODE}"
    echo "Default arch: ${ARCH}"
    echo "Release: ${RELEASE_FLAG}"
    echo "################################################################################"
}


while getopts v:m:a:r opt
do
    case "$opt" in 
    v)  SDK_VERSION=$OPTARG;;
    m)  MODE=$OPTARG;;
    a)  ARCH=$OPTARG;;
    r)  RELEASE_FLAG=1;;
    *)  show_help
        exit 1;;
        esac
done

    
if [ -z ${SDK_VERSION} ];then
    show_help
    exit 1
fi


update_code(){
    REPO=$1

    cd $REPO
    git reset --hard HEAD
    git checkout master
    git pull
    git submodule update --init --recursive
}

clean_dir(){
    DELETED_DIR=$1    

    cd ${ROOT_DIR}
    if [ -d ${DELETED_DIR} ]; then
        rm -rf ${DELETED_DIR}
    fi
    cd -
}

clean_workspace() {

    echo "Clean workspace..."

    cd ${ROOT_DIR}
    clean_dir Sampleapp_sourcecode
    clean_dir Sampleapp_binary
    clean_dir crosswalk-samples
    cd - 
}

get_crosswalk_demos() {
    if [ ! -d ${ROOT_DIR}/crosswalk-demos ]; then
        git clone https://github.com/crosswalk-project/crosswalk-demos.git ${ROOT_DIR}/crosswalk-demos
    fi
}

copy_crosswalk_samples_original() {
    if [ ! -d ${ROOT_DIR}/crosswalk-samples ]; then
        rm -fr ${ROOT_DIR}/crosswalk-samples
    fi

    cp -a ${ROOT_DIR}/crosswalk-samples-original ${ROOT_DIR}/crosswalk-samples
}

copy_demos_to_samples() {
    cp -a ${ROOT_DIR}/crosswalk-demos/HangOnMan ${ROOT_DIR}/crosswalk-samples/
    cp -fv ${ROOT_DIR}/crosswalk-demos/HangOnMan/manifest.json ${ROOT_DIR}/crosswalk-samples/HangOnMan/src/
    cp -a ${ROOT_DIR}/crosswalk-demos/MemoryGame ${ROOT_DIR}/crosswalk-samples/
    cp -fv ${ROOT_DIR}/crosswalk-demos/MemoryGame/manifest.json ${ROOT_DIR}/crosswalk-samples/MemoryGame/src/
}

copy_hexgl_to_samples() {
    cp -a ${ROOT_DIR}/HexGL ${ROOT_DIR}/crosswalk-samples/
}

modify_webrtc_config() {
    # subsitute the server IP and port in webrtc/client/main.js
    sed -i "s|var SERVER_IP = '192.168.0.25'|var SERVER_IP = '106.187.98.180'|" ${ROOT_DIR}/crosswalk-samples/webrtc/client/main.js
    sed -i "s|var SERVER_PORT = 9000|var SERVER_PORT = 9001|" ${ROOT_DIR}/crosswalk-samples/webrtc/client/main.js

}

modify_extensions_android_config() {
    if [ -n ${SDK_VERSION} ]; then
        if [ -f ${PKG_TOOLS_DIR}/crosswalk-${SDK_VERSION}-64bit.zip ]; then
            CROSSWALK_ZIP=${PKG_TOOLS_DIR}/crosswalk-${SDK_VERSION}-64bit.zip
            sed -i "s|8.37.189.14|${SDK_VERSION}|" ${ROOT_DIR}/crosswalk-samples/extensions-android/xwalk-echo-extension-src/build.xml

            if [ ! -d ${ROOT_DIR}/crosswalk-samples/extensions-android/xwalk-echo-extension-src/lib ]; then
                mkdir -pv ${ROOT_DIR}/crosswalk-samples/extensions-android/xwalk-echo-extension-src/lib
            fi

            cp -fv ${ROOT_DIR}/patch/ivy-2.4.0.jar ${ROOT_DIR}/crosswalk-samples/extensions-android/xwalk-echo-extension-src/tools/ivy-2.4.0.jar
            cp -fv ${PATCH_DIR64}/build.sh ${ROOT_DIR}/crosswalk-samples/extensions-android/build.sh

            # To adapt the build.xml, the file name must be crosswalk.zip
            rename_xwalk_64_32 ${CROSSWALK_ZIP} ${SDK_VERSION} 
            cp -fv ${ROOT_DIR}/patch/crosswalk.zip ${ROOT_DIR}/crosswalk-samples/extensions-android/xwalk-echo-extension-src/lib/crosswalk.zip
            unzip -q ${ROOT_DIR}/crosswalk-samples/extensions-android/xwalk-echo-extension-src/lib/crosswalk.zip -d ${ROOT_DIR}/crosswalk-samples/extensions-android/xwalk-echo-extension-src/lib/            
        else
            echo "${PKG_TOOLS_DIR}/crosswalk-${SDK_VERSION}.zip does not exist, please download it first !"
            exit 1
        fi
    fi

}

modify_spacedodge_config() {

    # Change package id of other version space-dodge-game, to void same apk name.
    sed -i "s/Space Dodge/Space Dodge2/g" ${ROOT_DIR}/crosswalk-samples/space-dodge-game/manifest-orientation-resize/manifest.json
    sed -i "s/org.xwalk.spacedodgegame/org.xwalk.spacedodgegame2/g" ${ROOT_DIR}/crosswalk-samples/space-dodge-game/manifest-orientation-resize/manifest.json

    sed -i "s/Space Dodge/Space Dodge3/g" ${ROOT_DIR}/crosswalk-samples/space-dodge-game/manifest-orientation-scale/manifest.json
    sed -i "s/org.xwalk.spacedodgegame/org.xwalk.spacedodgegame3/g" ${ROOT_DIR}/crosswalk-samples/space-dodge-game/manifest-orientation-scale/manifest.json

    sed -i "s/Space Dodge/Space Dodge4/g" ${ROOT_DIR}/crosswalk-samples/space-dodge-game/screen-orientation-resize/manifest.json
    sed -i "s/org.xwalk.spacedodgegame/org.xwalk.spacedodgegame4/g" ${ROOT_DIR}/crosswalk-samples/space-dodge-game/screen-orientation-resize/manifest.json

    sed -i "s/Space Dodge/Space Dodge5/g" ${ROOT_DIR}/crosswalk-samples/space-dodge-game/screen-orientation-scale/manifest.json
    sed -i "s/org.xwalk.spacedodgegame/org.xwalk.spacedodgegame5/g" ${ROOT_DIR}/crosswalk-samples/space-dodge-game/screen-orientation-scale/manifest.json
}

rename_xwalk_64_32() {
    # This function tries to rename the crosswalk-${VERSION}-64bit.zip to crosswalk.zip while
    # unzip it will get crosswalk-${VERSION} directory.

    XWALK_ZIP=$1
    XWALK_VERSION=$2

    cd ${ROOT_DIR}/patch
    rm -fv *.zip
    rm -fr ${ROOT_DIR}/patch/crosswalk-${XWALK_VERSION}
    rm -fr ${ROOT_DIR}/patch/crosswalk-${XWALK_VERSION}-64bit

    cp -fv ${XWALK_ZIP} ${ROOT_DIR}/patch
    unzip -q crosswalk-${XWALK_VERSION}-64bit.zip 
    mv -fv crosswalk-${XWALK_VERSION}-64bit crosswalk-${XWALK_VERSION}
    zip -qr crosswalk.zip crosswalk-${XWALK_VERSION}
    
    cd -
}

build_apk() {
    mode=$1
    arch=$2

    clean_dir Sampleapp_binary
    BINARY_DIR=${ROOT_DIR}/Sampleapp_binary
    mkdir -pv ${BINARY_DIR}
    cd ${BINARY_DIR}

    set -e

    cp -fv ${ROOT_DIR}/inst.py ${BINARY_DIR}

    # 1. extensions-android
    cd ${ROOT_DIR}/crosswalk-samples/extensions-android
    ./build.sh ${mode} ${arch} ${SDK_VERSION}
    mv -fv *.apk ${BINARY_DIR}
    cd ${BINARY_DIR}

    # 2. HangOnMan    
    ${CROSSWALK_PKG} --crosswalk=${CROSSWALK_ZIP} --platforms=android --android=${mode} --targets=${arch} --enable-remote-debugging ${ROOT_DIR}/crosswalk-samples/HangOnMan/src

    # 3. hello-world
    ${CROSSWALK_PKG} --crosswalk=${CROSSWALK_ZIP} --platforms=android --android=${mode} --targets=${arch} --enable-remote-debugging ${ROOT_DIR}/crosswalk-samples/hello-world

    # 4. HexGL
    ${CROSSWALK_PKG} --crosswalk=${CROSSWALK_ZIP} --platforms=android --android=${mode} --targets=${arch} --enable-remote-debugging ${ROOT_DIR}/crosswalk-samples/HexGL/assets/www

    # 5. MemoryGame
    ${CROSSWALK_PKG} --crosswalk=${CROSSWALK_ZIP} --platforms=android --android=${mode} --targets=${arch} --enable-remote-debugging ${ROOT_DIR}/crosswalk-samples/MemoryGame/src

    # 6. simd-mandelbrot
    ${CROSSWALK_PKG} --crosswalk=${CROSSWALK_ZIP} --platforms=android --android=${mode} --targets=${arch} --enable-remote-debugging ${ROOT_DIR}/crosswalk-samples/simd-mandelbrot

    # 7. space-dodge-game
    ${CROSSWALK_PKG} --crosswalk=${CROSSWALK_ZIP} --platforms=android --android=${mode} --targets=${arch} --enable-remote-debugging ${ROOT_DIR}/crosswalk-samples/space-dodge-game/base
    
    # 7.1 
    ${CROSSWALK_PKG} --crosswalk=${CROSSWALK_ZIP} --platforms=android --android=${mode} --targets=${arch} --enable-remote-debugging  ${ROOT_DIR}/crosswalk-samples/space-dodge-game/manifest-orientation-resize

    # 7.2
    ${CROSSWALK_PKG} --crosswalk=${CROSSWALK_ZIP} --platforms=android --android=${mode} --targets=${arch} --enable-remote-debugging  ${ROOT_DIR}/crosswalk-samples/space-dodge-game/manifest-orientation-scale

    # 7.3    
    ${CROSSWALK_PKG} --crosswalk=${CROSSWALK_ZIP} --platforms=android --android=${mode} --targets=${arch} --enable-remote-debugging  ${ROOT_DIR}/crosswalk-samples/space-dodge-game/screen-orientation-resize

    # 7.4
    ${CROSSWALK_PKG} --crosswalk=${CROSSWALK_ZIP} --platforms=android --android=${mode} --targets=${arch} --enable-remote-debugging  ${ROOT_DIR}/crosswalk-samples/space-dodge-game/screen-orientation-scale

    # 8. webgl
    ${CROSSWALK_PKG} --crosswalk=${CROSSWALK_ZIP} --platforms=android --android=${mode} --targets=${arch} --enable-remote-debugging ${ROOT_DIR}/crosswalk-samples/webgl

    # 9. webrtc
    ${CROSSWALK_PKG} --crosswalk=${CROSSWALK_ZIP} --platforms=android --android=${mode} --targets=${arch} --enable-remote-debugging ${ROOT_DIR}/crosswalk-samples/webrtc/client

    set +e

    cd ${ROOT_DIR}
    rm -rf Sampleapp_binary.zip
    if [ ${arch} == "arm64-v8a" ]; then
        friendly_arch="arm64"
    else
        friendly_arch=${arch}
    fi

    rm -rf Sampleapp_binary-${SDK_VERSION}-${mode}-${friendly_arch}.zip
    zip -qr Sampleapp_binary-${SDK_VERSION}-${mode}-${friendly_arch}.zip Sampleapp_binary
}

start_release_work() {
    if [ ${RELEASE_FLAG} -eq 1 ]; then
        build_apk embedded x86_64
        build_apk embedded arm64-v8a
        build_apk shared x86_64
        build_apk shared arm64-v8a
        

        rm -rf Sampleapp_sourcecode.zip

        # Remove the crosswalk-${VERSION} and crosswalk.zip file in lib
        # Remove the build directory which is generated by ant
        rm -fr ${ROOT_DIR}/crosswalk-samples/extensions-android/xwalk-echo-extension-src/lib
        rm -fr ${ROOT_DIR}/crosswalk-samples/extensions-android/xwalk-echo-extension-src/build

        # Modify the crosswalk version back to make sure the source code is original.
        sed -i "s|${SDK_VERSION}|8.37.189.14|" ${ROOT_DIR}/crosswalk-samples/extensions-android/xwalk-echo-extension-src/build.xml

        rm -fr ${ROOT_DIR}/crosswalk-samples/.git
        zip -qr Sampleapp_sourcecode.zip crosswalk-samples
        cp -fv Sampleapp_binary-${SDK_VERSION}-*.zip ${DEST_BINARY_DIR}
        cp -fv Sampleapp_sourcecode.zip ${DEST_BINARY_DIR}

        echo "SampleApp sourcecode and binary for release has been updated !!!"
        echo "You can check it here : http://otcqa.sh.intel.com/qa-auto/live/Xwalk-testsuites/Sampleapp_SourceCode_And_Binary/"
    fi
}

################################################################################
# Main
################################################################################

show_params
clean_workspace

get_crosswalk_demos

update_code ${ROOT_DIR}/crosswalk-demos
update_code ${ROOT_DIR}/crosswalk-samples-original

copy_crosswalk_samples_original
copy_demos_to_samples
copy_hexgl_to_samples

modify_webrtc_config
modify_spacedodge_config
modify_extensions_android_config


start_release_work

clean_dir crosswalk-samples
clean_dir Sampleapp_binary

