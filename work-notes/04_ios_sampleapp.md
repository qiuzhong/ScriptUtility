# How to build crosswalk-ios/Demos/Sample/SampleApp?
## Steps:
1. Clone the crosswalk-ios repo and download the dependency packages, open the Xcode

    ```Bash
    $ git clone https://github.com/crosswalk-project/crosswalk-ios.git
    $ cd crosswalk-ios
    $ cd Demos/
    $ cd Sample/
    $ pod install
    $ open SampleApp.xcworkspace/
    ```

2. Connec the iOS device to MacBook Pro Retina, and build the application

    Select >
    Select SampleApp
    Select Deivce->Web QA iPad(This is the iPad name)
    Run

3. Test the SampleApp by following the instructions
[SampleApp Function](https://github.com/crosswalk-project/crosswalk-test-suite/blob/master/misc/sampleapp-ios-tests/sampleapp/SampleApp_Function.html)