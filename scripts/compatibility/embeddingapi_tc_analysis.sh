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

CTS_DIR="/home/orange/01_qiuzhong/work_space/release/crosswalk-test-suite-test"
OFFICAL_REFIX_DEST_DIR="/data/TestSuites_Storage/live/android"
TEST_PREFIX_DEST_DIR="/home/orange/01_qiuzhong/temp/live/android"

if [ ${TEST_FLAG} == "true" ]; then
	DEST_DIR=${TEST_PREFIX_DEST_DIR}
else
	DEST_DIR=${OFFICAL_REFIX_DEST_DIR}
fi

XWALK_VERSION=${N_VER}
BRANCH="master"

COVERITY_DIR=${DEST_DIR}/${BRANCH}/${XWALK_VERSION}/coverity

init_coverity() {
	for embeddingapi_tc in ${XWALK_EMBEDDINGAPI_TC}
	do
		if [ ! -d ${COVERITY_DIR}/${embeddingapi_tc} ]; then
			mkdir -pv ${COVERITY_DIR}/${embeddingapi_tc}
		fi
	done

	for usecase_embeddingapi in ${XWALK_USECASE_EMBEDDING_TC}
	do
		if [ ! -d ${COVERITY_DIR}/${usecase_embeddingapi} ]; then
			mkdir -pv ${COVERITY_DIR}/${usecase_embeddingapi}
		fi
	done

    chmod u+x ${CTS_DIR}/tools/build/pack.py
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

	rm -fr crosswalk-webview
	if [ -d ${PKG_TOOLS_DIR}/crosswalk-webview-${XWALK_VERSION}-${arch} ]; then
		cp -a ${PKG_TOOLS_DIR}/crosswalk-webview-${XWALK_VERSION}-${arch} ./crosswalk-webview
	else
		echo "${PKG_TOOLS_DIR}/crosswalk-webview-${XWALK_VERSION}-${arch} not found!"
		exit 1
	fi

	cd -
}

cov_build_embeddingapi_tc() {
	chmod u+x ${CTS_DIR}/tools/build/pack.py
    
    ROOT_DIR=$1

	ERRORS_DIR="output/errors"
	cd ${ROOT_DIR}
	for embeddingapi_tc in ${XWALK_EMBEDDINGAPI_TC}
	do
		cd ${CTS_DIR}/${embeddingapi_tc}
		rm -fv *.zip
		git clean -dfx .

		cov-build --dir ./ ../../tools/build/pack.py -t embeddingapi --pack-type ant
		cov-analyze-java --dir ./ --concurrency --security --rule --enable-constraint-fpp --enable-fnptr --enable-virtual
		cov-format-errors --dir ./

		if [ -d ${ERRORS_DIR} ]; then
			cp -fr ${ERRORS_DIR} ${COVERITY_DIR}/${embeddingapi_tc}/
		else
			echo "No error directory found!"
		fi

		cd -
	done

	for usecase_embeddingapi in ${XWALK_USECASE_EMBEDDING_TC}
	do
		cd ${CTS_DIR}/${usecase_embeddingapi}
		rm -fv *.zip
		git clean -dfx .

		cov-build --dir ./ ../../tools/build/pack.py -t embeddingapi --pack-type ant
		cov-analyze-java --dir ./ --concurrency --security --rule --enable-constraint-fpp --enable-fnptr --enable-virtual
		cov-format-errors --dir ./

		if [ -d ${ERRORS_DIR} ]; then
			cp -fr ${ERRORS_DIR} ${COVERITY_DIR}/${usecase_embeddingapi}/
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
cov_build_embeddingapi_tc ${CTS_DIR}
