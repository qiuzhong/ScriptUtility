# Cordova Test Suites

The cordova test suites contain the following test suites:

* cordova/cordova-feature-android-tests
* cordova/cordova-appsecurityapi-android-tests
* cordova/cordova-sampleapp-android-tests
* cordova/cordova-webapp-android-tests
* usecase/usecase-cordova-android-tests

## How to pack cordova test suite packages on master branch?
1. Make sure **crosswalk-test-suite/tools/cordova_plugin/cordova-plugin-crosswalk-webview** exist.
2. Make sure **crosswalk-test-suite/VERSION** matches to the version your want.
3. Install crosswalk-${VERSION}.aar file locally and make sure **~/.m2/repository/org/xwalk/** has the according directories.
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

5. Go to > crosswalk-test-suite/tools/build, run

    ```Bash
    ./pack.py -t cordova --sub-version 4.x -a arm -m embedded
    ```
