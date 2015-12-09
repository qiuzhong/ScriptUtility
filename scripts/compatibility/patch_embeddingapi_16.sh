#!/bin/bash

###############################################################################
#   This script aims to patch the embeddingapi test suite so that it can apply
#   some mismatch version of Crosswalk version. Otherwise, the compliation will
#   not pass
#   Written by: Zhong Qiu <zhongx.qiu>
#   Date:       2015-12-09
###############################################################################


CWD=$(pwd)
source ${CWD}/embeddingapi_patch_list

SRC_DIR="/home/orange/00_jiajia/work_space/release/crosswalk-test-suite-16/embeddingapi"
DEST_DIR="/home/orange/01_qiuzhong/work_space/compatibility/crosswalk-test-suite-16/embeddingapi"
PATCH_BACKUP_DIR="/home/orange/01_qiuzhong/04-work/patch/crosswalk-test-suite-16/embeddingapi"


backup_embeddingapi_patch() {
    cd ${SRC_DIR}

    for patch in ${PATCH_LIST}
    do 
        path_dir=$(dirname ${patch})
        echo "${path_dir}"
        if [[ ! -d ${PATCH_BACKUP_DIR}/${path_dir} ]]; then
            mkdir -pv ${PATCH_BACKUP_DIR}/${path_dir}
        fi

        cp -fv ${SRC_DIR}/${patch} ${PATCH_BACKUP_DIR}/${patch}
    done


}

patch_embeddingapi_tc() {
    for patch in ${PATCH_LIST}
    do
        cp -fv ${PATCH_BACKUP_DIR}/${patch} ${DEST_DIR}/${patch}
    done

}

# backup_embeddingapi_patch

patch_embeddingapi_tc