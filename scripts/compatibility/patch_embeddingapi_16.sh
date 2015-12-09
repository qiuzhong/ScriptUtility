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

# cd ${DEST_DIR}
for patch in ${PATCH_LIST}
do
    cp -fv ${SRC_DIR}/${patch} ${DEST_DIR}/${patch}
done