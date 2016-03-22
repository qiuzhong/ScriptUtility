# Crosswalk environment setup
To build a Crosswalk application and packing test suite packages for Android, please conform the following instructions

## Install Android SDK
Android SDK requires the JRE, so you first need install JDK. Oracle JDK8 has been checked to satisfy the requirements.

### Install Oracle JDK8
Get the Oracle JDK from Oracle official website and install the deb package.
```Bash
$ tar -xvf jdk-8u74-linux-x64.tar.gz
$ mv -fv jdk1.8.0_74/ <JDK/PATH/TO/LOCATE>/jdk
$ vim ~/.bashrc
export JAVA_HOME=/home/apple/workspace/apple/app/jdk
export PATH=$PATH:$JAVA_HOME/bin
```

### Install Android SDK for Linux
unzip android-sdk-linux.tar.gz and set the ANDROID_HOME environment
```Bash
$ vim ~/.bashrc

export ANT_HOME=/home/apple/workspace/apple/app/ant
export PATH=$PATH:$ANT_HOME/apache-ant-1.9.6/bin
export MAVEN_HOME=/home/apple/workspace/apple/app/maven
export PATH=$PATH:$MAVEN_HOME/apache-maven-3.3.9/bin
export ANDROID_HOME=/home/apple/workspace/apple/app/android-sdk-linux
export PATH=$PATH:$ANDROID_HOME/tools:$ANDROID_HOME/build-tools:$ANDROID_HOME/platform-tools
```

### Install Node
```Bash
$ tar -xvf node-v4.2.4.tar.gz
$ cd node-v4.2.4/
$ ./configure
$ make -j 4
$ sudo make install

$ npm config set proxy http://child-prc.intel.com:913
$ npm config set https-proxy http://child-prc.intel.com:913

$ vim ~/.bashrc
export NODE_PATH=/usr/local/lib/node_modules
```

### Install Crosswalk-app-tools
```Bash
$ git clone https://github.com/crosswalk-project/crosswalk-app-tools.git
$ npm install --verbose
$ vim ~/.bashrc

export CROSSWALK_APP_TOOLS_DIR=/home/apple/workspace/apple/app/crosswalk-app-tools
export PATH=$PATH:$CROSSWALK_APP_TOOLS_DIR/src
export CROSSWALK_APP_TOOLS_CACHE_DIR=/home/apple/workspace/apple/pkg_tools_zip
```

### Install Cordova-cli
```Bash
$ sudo cnpm install -g cordova --verobse
```

### Install necessary tools for deb build
If you encounter this error:
> debuild: not found

You can fix it by:

```Bash
$ sudo apt-get install devscripts
```

When you encounter this error:
> debuild: fatal error at line 1364:
> dpkg-buildpackage -rfakeroot -D -us -uc failed

You can fix it by:

```Bash
$ sudo apt-get install debhelper
```
