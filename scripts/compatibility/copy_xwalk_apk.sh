#!/bin/bash

CWD=$(pwd)
source ${CWD}/config

cp_xwalk_apk() {
    cp -a ${PKG_TOOLS_DIR}/crosswalk-apks-$1-$2 ${DEST_DIR}/runtimelib/$2
    if [[ -f ${DEST_DIR}/runtimelib/$2/crosswalk-apks-$1-$2/XWalkAppHelloWorld.apk ]]; then
        rm -fv ${DEST_DIR}/runtimelib/$2/crosswalk-apks-$1-$2/XWalkAppHelloWorld.apk
    fi

    if [[ -f ${DEST_DIR}/runtimelib/$2/crosswalk-apks-$1-$2/XWalkRuntimeLibLzma.apk ]]; then
        rm -fv ${DEST_DIR}/runtimelib/$2/crosswalk-apks-$1-$2/XWalkRuntimeLibLzma.apk
    fi
}

for arch in ${ARCH}
do
    cp_xwalk_apk ${N_VER} ${arch}
    cp_xwalk_apk ${N_1_VER} ${arch}
    cp_xwalk_apk ${N_2_VER} ${arch}
    cp_xwalk_apk ${N_3_VER} ${arch}
done