# Build And Install Commands

Run these commands from the repository root.

## Build, pack, and force install into the test app

```sh
cd android-sdk && sh gradlew :CortexDecoderLibrary:assembleEdkRelease && cd .. && cp android-sdk/CortexDecoderLibrary/build/outputs/aar/CortexDecoderLibrary-edk-release.aar react-native-sdk/android/libs/CortexDecoderLibrary.aar && cd react-native-sdk && npm run codegen && npm run build && npm run pack && cp cortex-decoder-react-native-2.2.0.tgz ../react-native-test-app/cortex-decoder-react-native-2.2.0.tgz && cd ../react-native-test-app && npm install ./cortex-decoder-react-native-2.2.0.tgz --force
```

## Build, pack, force install, and launch Android

```sh
cd android-sdk && sh gradlew :CortexDecoderLibrary:assembleEdkRelease && cd .. && cp android-sdk/CortexDecoderLibrary/build/outputs/aar/CortexDecoderLibrary-edk-release.aar react-native-sdk/android/libs/CortexDecoderLibrary.aar && cd react-native-sdk && npm run codegen && npm run build && npm run pack && cp cortex-decoder-react-native-2.2.0.tgz ../react-native-test-app/cortex-decoder-react-native-2.2.0.tgz && cd ../react-native-test-app && npm install ./cortex-decoder-react-native-2.2.0.tgz --force && npm run android
```

## Build standalone Android release APK

Use this when the APK must run on a device without Metro / localhost 8081.
In Android Studio, select the `release` build variant before building the APK. A `debug` APK is expected to look for Metro on port 8081.

```sh
cd android-sdk && sh gradlew :CortexDecoderLibrary:assembleEdkRelease && cd .. && cp android-sdk/CortexDecoderLibrary/build/outputs/aar/CortexDecoderLibrary-edk-release.aar react-native-sdk/android/libs/CortexDecoderLibrary.aar && cd react-native-sdk && npm run codegen && npm run build && npm run pack && cp cortex-decoder-react-native-2.2.0.tgz ../react-native-test-app/cortex-decoder-react-native-2.2.0.tgz && cd ../react-native-test-app && npm install ./cortex-decoder-react-native-2.2.0.tgz --force && cd android && ./gradlew clean assembleRelease
```

The release APK is generated at:

```sh
react-native-test-app/android/app/build/outputs/apk/release/app-release.apk
```