#!/bin/bash

N=16
cd /home/orange/01_qiuzhong/temp/compatibility

if [[ ! -d ${N} ]]; then
    mkdir ${N}
else
    echo "${N} already exists!"
fi

cd ${N}

if [[ ! -d runtimelib ]]; then
    mkdir -pv runtimelib/{arm,x86}
else
    echo "runtimelib already exists!"
fi

if [[ ! -d test_suites ]]; then
    mkdir -pv test_suites/{cordova,crosswalk}/{crosswalk-14,crosswalk-15,crosswalk-16,crosswalk-17}/{arm,x86}
else
    echo "test_suites already exists!"
fi
