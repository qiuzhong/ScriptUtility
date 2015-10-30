# Cordova Test Suites

The cordova test suites contain the following test suites:

* cordova/cordova-feature-android-tests
* cordova/cordova-appsecurityapi-android-tests
* cordova/cordova-sampleapp-android-tests
* cordova/cordova-webapp-android-tests
* usecase/usecase-cordova-android-tests

## How to pack cordova test suite packages on master branch?
1. Make sure **crosswalk-test-suite/tools/cordova_plugin/cordova-plugin-crosswalk-webview** exist.
2. Make sure **crosswalk-test-suite/VERSION** matches to the version your want. Here is an example:

    ```
    "main-version": "17.45.426.0",
    "crosswalk-branch": "canary",
    ```

3. Install **crosswalk-17.45.426.0.aar** file locally and make sure **~/.m2/repository/org/xwalk/** has the according directories, use command:

    ```
    mvn install:install-file -DgroupId=org.xwalk -DartifactId=xwalk_core_library -Dversion=17.45.426.0 -Dpackaging=aar -Dfile=/data/jiajiax_shared/pkg_tools/crosswalk-17.45.426.0.aar -DgeneratePom=true
    ```

4. Modify **crosswalk-test-suite/tools/cordova_plugin/cordova-plugin-crosswalk-webview/platforms/android/xwalk.gradle**, and change 

    ```
    maven() {
        //blah blah
    }
    ```
    to

    ```
    mavenLocal()
    ```

5. Go to the root directory of each test suite, run

    ```
    ../../tools/build/pack.py -t cordova --sub-version 4.x -a arm -m embedded
    ```

## How to pack cordova sample apps apk on master branch?
6. Go to **crosswalk-test-suite/tools/build**, run

    ```Bash
    ./pack_cordova_sample.py -n helloworld --sub-version 4.x -a arm -m embedded
    ```

7. At present, CIRC and Eh cordova sample apps cannot use this modification above as there are some problems with the cca tool. So you have to hack
**crosswalk-test-suite/tools/cordova_plugin/cordova-plugin-crosswalk-webview/platforms/android/xwalk.gradle**
Change

    ```
    ext.xwalkVersion = getConfigPreference("xwalkVersion")
    ```
to
    ```
    ext.xwalkVersion = "17.45.426.0"
    ```
Then, go to step 6.
