# How to setup building environment for the test suite packing for Windows 8?
This document aim to setup envrionment on "a completely clean" Windows 8 system

## Pre-conditions:
* wix library
* Python 2.7
* nodejs
* github for Windows

Remember when install Python and Node, choose "Add to the path" option.

## Install crosswalk-app-tools
1. Set git proxy server

```Bash
$ git config --global http.proxy http://child-prc.intel.com:913
$ git config --global http.proxy http://child-prc.intel.com:913
```

1.2 Get crosswalk-app-tools

```Bash
$ git clone https://github.com/crosswalk-project/crosswalk-app-tools.git
```

Set environment variable
> CROSSWALK_APP_TOOLS=C:\xwalk\crosswalk-app-tools

1.3 Set npm proxy server

```Bash
$ npm config set proxy http://child-prc.intel.com:913
$ npm config set https-proxy http://child-prc.intel.com:913
```

1.4 Installl crosswalk-app-tools

```Bash
$ cd crosswalk-app-tools
$ npm install --verbose
```

Sometimes, installing crosswalk-app-tools may fail, in that case, you need to run 

```Bash
$ npm install --verbose
```

again and make sure return message is like this:

> [0, true]


## Get the crosswalk-demos

```Bash
$ git submodule update --init --recursive
```

## Get the crosswalk-samples/crosswalk-tests-suite/demo-express/HexGL

```Bash
$ git clone https://github.com/crosswalk-project/crosswalk-samples.git
$ git clone https://github.com/crosswalk-project/crosswalk-tests-suite.git
$ git clone https://github.com/crosswalk-project/demo-express.git
$ git clone https://github.com/BKcore/HexGL.git
```

## Get the AppSecurityApi

```Bash
$ cd C:\xwalk\dependency
$ git clone https://github.com/01org/AppSecurityApi.git
```

## Add git to the path:

Locate your Git Shell path, and find the git command path, then append it to the path environment

## Add WiX Toolset to the path

