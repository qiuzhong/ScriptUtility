###############################################################################
# Need to update!
###############################################################################

N_VER="17.46.448.0"
N_1_VER="16.45.421.19"
N_2_VER="15.44.384.13"
N_3_VER="14.43.343.25"
N_4_VER="14.43.343.25"
N_PLUS_1_VER="18.46.470.0"

N="17"
N1="16"
N2="15"
N3="14"
N4="13"
NPLUS1="18"

ALPHA="release-testing"
ALPHA_1="1.5.0"
ALPHA_2="1.4.0"
ALPHA_3="1.3.0"

###############################################################################
# End to update!
###############################################################################

MODES="
embedded
shared
"

ARCH="
arm
x86
"

ARCH64BIT="
arm64
x86_64
"

RELEASE_VERSION="01"

WORKSPACE="/home/orange/01_qiuzhong/work_space/compatibility"
PKG_TOOLS_DIR="/data/jiaxxx_shared/pkg_tools"
PKG_TOOLS_DIR64="/data/jiaxxx_shared/pkg_tools_64"
PKG_TOOLS_LITE_DIR="/data/jiaxxx_shared/pkg_tools_lite"
CROSSWALK_APP_TOOLS_LITE_CACHE_DIR="/home/orange/pkg_tools_lite_zip"
DEMOEX_DIR="/home/orange/00_jiajia/work_space/release/demo-express"
GRADLE="platforms/android/xwalk.gradle"


###############################################################################
# Need to update!
###############################################################################

DEST_DIR="/home/orange/01_qiuzhong/temp/compatibility/16"

###############################################################################
# End to update!
###############################################################################


###############################################################################
# XWALK Test Suites List
###############################################################################
XWALK_SAMPLE_APPS_TC="
misc/sampleapp-android-tests
"

XWALK_USECASE_TC="
usecase/usecase-webapi-xwalk-tests
usecase/usecase-wrt-android-tests
usecase/usecase-wrt-auto-tests
"

XWALK_USECASE_EMBEDDING_TC="
usecase/usecase-embedding-android-tests
"

XWALK_WEBAPI_TC="
misc/webapi-service-tests
misc/webapi-service-docroot-tests
misc/webapi-noneservice-tests
"

XWALK_EMBEDDINGAPI_TC="
embeddingapi/embedding-api-android-tests
embeddingapi/embedding-asyncapi-android-tests
"

###############################################################################
# Cordova Test Suites List
###############################################################################
CORDOVA_CIRC_URL="https://github.com/flackr/circ.git"
CORDOVA_EH_URL="https://github.com/MobileChromeApps/workshop-cca-eh.git"
CORDOVA_MOBILESPEC_URL="https://github.com/crosswalk-project/crosswalk-test-suite.git"

CORDOVA_SAMPLE_APPS_TC="
cordova/cordova-appsecurityapi-android-tests
cordova/cordova-feature-android-tests
cordova/cordova-sampleapp-android-tests
cordova/cordova-webapp-android-tests
"

CORDOVA_SAMPLE_APPS="
helloworld
"

USECASE_CORDOVA="
usecase/usecase-cordova-android-tests
"

CORDOVA_API="
mobilespec
"
