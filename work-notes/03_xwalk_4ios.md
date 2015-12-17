# Crosswalk for iOS notes

## Pre-conditions:
* Xcode
* Valid Apple Developer Account
* NPM
* Crosswalk App Tools with iOS backend

## How to create a Crosswalk web application?

```Bash
$ crosswalk-app-tools/src/crosswalk-app create org.example.bar --platform=ios
$ cd org.example.bar
$ crosswalk-app build
```

## How to create a Crosswalk hybrid application?
### Create the application project
1. Open Xcode. Create an iOS application project with the "Single View Application" template in the working directory. For this example, we use "Echo". Use Swift for convenience.

2. Use CocoaPods to integrate the crosswalk-ios library and Crosswalk extensions (if needed) into the demo application. For the CocoaPods installation and usage, please refer to: CocoaPods.

    In the Echo directory, create a file called Podfile:

    ```Bash
     cd Echo; (in the workspace root directory)
     touch Podfile;
    ```

    With the contents as below:

    ```
     platform :ios, '8.1'
     use_frameworks!
     pod 'crosswalk-ios', '~> 1.2'
    ```

    This tells CocoaPods that the deploy target is iOS 8.1+ and to integrate library crosswalk-ios with the latest version of 1.2.x. Remember to add use_frameworks! because crosswalk-ios is partly written in Swift and it has to be built as a framework instead of a static library.

    Install Pods target into the project. Quit the Xcode first, then in the Echo directory, use command:
    (in the root directory)

    ```
     pod install
    ```

    After the installation, you will find an Echo.xcworkspace is generated, and CocoaPods output will notify you to use this workspace instead of the Echo.xcodeproj from now on.

    Open the Echo.xcworkspace. There will be two projects: Echo and Pods.

    For quick test, replace the contents of the auto-generated ViewController.swift with the corresponding file in crosswalk-ios/AppShell/AppShell/ViewController.swift, which has set up a XWalkView instance for you already.

3. Create a directory called www in Echo for the HTML5 files and resources.

4. Create the index.html file as your entry page with the contents as follows:

    ```HTML
     <html>
       <head>
         <meta name='viewport' content='width=device-width' />
         <title>Echo demo of Crosswalk</title>
       </head>
       <body>
         <h2>Echo Demo of Crosswalk</h2>
       </body>
     </html>
    ```

5. Add the www directory into the project.(in root directory)

    In File -> Add Files to "Echo"..., choose the www directory and select Create folder reference.

6. Create manifest.plist to describe the application's configuration.(in the root directory)

    In File -> New... -> File..., choose iOS -> Resource -> Property List. Create a plist file with name manifest.plist in Echo directory. This manifest file will be loaded at application startup;

    Add an entry with the key: start_url and the string value: index.html. This is the entry page. XWalkView will locate it in the www directory.

    ```
    Key     Type        Value
    Root
            start_url   index.html
    ```

    The Echo demo is ready to run now. Press 'Run' button and it will be deployed and run on your iOS simulator.

## Notes

### The file tree is like this

    ```Bash
    $ cd Echo/
    $ ls
    Echo             Echo.xcworkspace EchoUITests      Podfile.lock     manifest.plist
    Echo.xcodeproj   EchoTests        Podfile          Pods             www
    ```