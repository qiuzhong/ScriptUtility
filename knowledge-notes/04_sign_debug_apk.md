# How to sign a debug mode apk?

## Generate a keystore
```Bash
$ keytool -genkey -v -keystore <filename>.keystore -alias <key-name> -keyalg RSA -keysize 2048 -validity 10000
```

## Sign the APK
```
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore iapdemo.keystore mono.samples.helloworld.apk publishingdoc
```

ant release
```
jarsigner -verbose -sigalg SHA1withRSA -digestalg SHA1 -keystore iapdemo.keystore org.xwalk.iapdemo-1.0.0-release-unsigned.armeabi-v7a.apk iapdemo
jarsigner -verify -verbose -certs oorg.xwalk.iapdemo-1.0.0-release-unsigned.armeabi-v7a.apk
zipalign -v 4 org.xwalk.iapdemo-1.0.0-release-unsigned.armeabi-v7a.apk iapdemo.apk
```

## Reference
[Sign APK](http://developer.android.com/tools/publishing/app-signing.html)
