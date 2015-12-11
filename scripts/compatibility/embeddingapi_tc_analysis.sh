#!/bin/bash

###############################################################################
#	This script will try to analyse the coverity of embeddingapi test suites.
#	A cov-build tool must be installed and configurated correctly.
#	
#	Written by: Zhong Qiu <zhongx.qiu@intel.com>
#	Date:		2015-12-11
###############################################################################

CWD=$(pwd)
source ${CWD}/config

TEST_FLAG="true"

CTS_DIR="/home/apple/02_qiuzhong/workspace/crosswalk-test-suite"
OFFICAL_REFIX_DEST_DIR="/mnt/suites_storage/live/android"
TEST_PREFIX_DEST_DIR="/home/apple/02_qiuzhong/temp/live/android"

if [ ${TEST_FLAG} == "true" ]; then
	DEST_DIR=${TEST_PREFIX_DEST_DIR}
else
	DEST_DIR=${OFFICAL_REFIX_DEST_DIR}
fi

VERSION=${N_VER}
BRANCH="master"

COVERITY_DIR=${DEST_DIR}/${BRANCH}/${VERSION}/coverity

init_coverity() {
	for embeddingapi_tc in ${XWALK_EMBEDDINGAPI_TC}
	do
		if [ ! -d ${COVERITY_DIR}/${embeddingapi_tc} ]; then
			mkdir -pv ${COVERITY_DIR}/${embeddingapi_tc}
		fi
	done

	for usecase_embeddingapi in ${XWALK_USECASE_TC}
	do
		if [ ! -d ${COVERITY_DIR}/${embeddingapi_tc} ]; then
			mkdir -pv ${COVERITY_DIR}/${embeddingapi_tc}
		fi
	done


}

update_code() {
	ROOT_DIR=$1
	cd ${ROOT_DIR}

	git reset --hard HEAD
	git pull

	cd -
}

update_version() {
	ROOT_DIR=$1
	XWALK_VERSION=$2

	cd ${ROOT_DIR}

	sed -i "s|\"main-version\": \"\([^\"]*\)\"|\"main-version\": \"${XWALK_VERSION}\"|g" VERSION
	sed -i "s/beta/canary/" VERSION

	cd -
}

copy_xwalk_webview() {
	ROOT_DIR=$1
	XWALK_VERSION=$2
	arch=$3

	cd ${ROOT_DIR}/tools

	if [ -d ${PKG_TOOLS_DIR}/crosswalk-webview-${XWALK_VERSION}-${arch} ]; then
		cp -a ${PKG_TOOLS_DIR}/crosswalk-webview-${XWALK_VERSION}-${arch} ./crosswalk-webview
	else
		echo "${PKG_TOOLS_DIR}/crosswalk-webview-${XWALK_VERSION}-${arch} not found!"
		exit 1
	fi

	cd -
}

cov_build_embeddingapi_tc() {
	ROOT_DIR=$1

	cd ${ROOT_DIR}
	for embeddingapi_tc in ${XWALK_EMBEDDINGAPI_TC}
	do
		cd ${embeddingapi_tc}
		cov-build --dir ./ ../../tools/build/pack.py -t embeddingapi --pack-type ant
		cov-analyze-java --dir ./ --concurrency --security --rule --enable-constraint-fpp --enable-fnptr --enable-virtual
		cov-format-errors --dir ./

		if [ -d output/error ]; then
			cp -fr output/error ${COVERITY_DIR}/${embeddingapi_tc}/
		else
			echo "No error directory found!"
		fi

		cd -
	done

	for usecase_embeddingapi in ${XWALK_USECASE_TC}
	do
		cd ${usecase_embeddingapi}
		cov-build --dir ./ ../../tools/build/pack.py -t embeddingapi --pack-type ant
		cov-analyze-java --dir ./ --concurrency --security --rule --enable-constraint-fpp --enable-fnptr --enable-virtual
		cov-format-errors --dir ./

		if [ -d output/error ]; then
			cp -fr output/error ${COVERITY_DIR}/${usecase_embeddingapi}/
		else
			echo "No error directory found!"
		fi
	done

}

###############################################################################
# Main
###############################################################################

init_coverity
update_code ${CTS_DIR}
update_version ${CTS_DIR} ${XWALK_VERSION}
copy_xwalk_webview ${CTS_DIR} ${XWALK_VERSION} x86

