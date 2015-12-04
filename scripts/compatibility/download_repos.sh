#!/bin/bash

CWD=$(pwd)
source ${CWD}/config

cd ${WORKSPACE}
git clone https://github.com/crosswalk-project/crosswalk-test-suite.git

cp -a crosswalk-test-suite crosswalk-test-suite-14
cd crosswalk-test-suite-14
git checkout Crosswalk-14
cd -

cp -a crosswalk-test-suite crosswalk-test-suite-15
cd crosswalk-test-suite-15
git checkout Crosswalk-15
cd -

cp -a crosswalk-test-suite crosswalk-test-suite-16
cd crosswalk-test-suite-16
git checkout Crosswalk-16
cd -
