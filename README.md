# Flutter - Biometric Authentication

This project demonstrates the implementation of biometric authentication in a Flutter app. The application provides two authentication options: biometric-only authentication (fingerprint/face recognition) and flexible authentication (biometric, PIN, or pattern). The app verifies the availability of biometric features on the device before displaying authentication options.

## Table of Contents

- [Features](#features)
- [Technologies Used](#technologies-used)
- [Platform-Specific Configuration](#platform-specific-configuration)
- [Installation](#installation)
- [Usage](#usage)
- [License](#license)
- [Author](#author)

## Features

- **Biometric Authentication:** Supports fingerprint and Face ID for secure login.
- **Alternative Authentication:** Users can authenticate using other device-supported options (e.g., PIN, pattern).
- **Dynamic UI:** Displays authentication options only if the device supports biometrics; otherwise, displays an appropriate message.
- **State Management with GetIt:** Dependency injection for efficient service management.
- **Navigation:** Smooth navigation from the login screen to the home screen and vice versa.

## Technologies Used

- **Programming Language:** Dart
- **Framework:** Flutter
- **State Management Library:** get_it (For Dependency Injection)
- **Biometric Authentication:** local_auth package
- **Others:**
  - Android Studio / Visual Studio Code for development
  - Git for version control

## Platform-Specific Configuration

- **iOS**
1. To enable biometric authentication on iOS devices, you need to add the following permission in the **Info.plist** file located inside the ios folder:

```bash
<key>NSFaceIDUsageDescription</key>
<string>Why is my app authenticating using face ID?</string>
```

- **Android**

1. Add the following permission in the **AndroidManifest.xml** file located inside the android folder:

```bash
<manifest xmlns:android="http://schemas.android.com/apk/res/android"
          package="com.example.app">
  <uses-permission android:name="android.permission.USE_BIOMETRIC"/>
</manifest>
```

2. Modify the **MainActivity.kt** file by replacing **FlutterActivity** with **FlutterFragmentActivity**:

```bash
import io.flutter.embedding.android.FlutterFragmentActivity

class MainActivity: FlutterFragmentActivity() {}
```

## Installation

Follow these steps to get the project up and running locally:

```bash
# Clone the repository
git clone https://github.com/Packiyalakshmi-M/Flutter-Biometric-Auth.git

# Navigate into the project directory
cd biometric_auth_app

# Install dependencies
flutter pub get
```

## Usage

The following snippet shows the service class which has an implementation for biometric authentication:

```
import 'package:biometric_auth_app/Services/BiometricService/IBiometricService.dart';
import 'package:local_auth/local_auth.dart';

class BiometricService implements IBiometricService {
  final LocalAuthentication localAuthentication = LocalAuthentication();

  @override
  Future<bool> authenticateAnyway() async {
    try {
      bool authenticated = await localAuthentication.authenticate(
        localizedReason: 'Let OS determine authentication method',
        options: const AuthenticationOptions(
          stickyAuth: true,
        ),
      );
      return authenticated;
    } catch (ex) {
      print("Exception: ${ex.toString()}");
      return false;
    }
  }

  @override
  Future<bool> authenticateWithBiometrics() async {
    try {
      bool authenticated = await localAuthentication.authenticate(
        localizedReason:
            'Scan your fingerprint (or face or whatever) to authenticate',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      return authenticated;
    } catch (ex) {
      print("Exception: ${ex.toString()}");
      return false;
    }
  }

  @override
  Future<bool> canCheckBiometricsAuth() async {
    try {
      bool canCheck = await localAuthentication.canCheckBiometrics;
      return canCheck;
    } catch (ex) {
      print("Exception: ${ex.toString()}");
      return false;
    }
  }

  @override
  Future<bool> cancelAuthentication() async {
    try {
      await localAuthentication.stopAuthentication();
      return true;
    } catch (ex) {
      print("Exception: ${ex.toString()}");
      return false;
    }
  }

  @override
  Future<List<BiometricType>> getAvailableBiometricOptions() async {
    try {
      List<BiometricType> availableBiometrics =
          await localAuthentication.getAvailableBiometrics();
      return availableBiometrics;
    } catch (ex) {
      print("Exception: ${ex.toString()}");
      return [];
    }
  }

  @override
  Future<bool> isBiometricsAvailable() async {
    try {
      bool isSupported = await localAuthentication.isDeviceSupported();
      return isSupported;
    } catch (ex) {
      print("Exception: ${ex.toString()}");
      return false;
    }
  }
}

```

## License

This project is open source and available under the MIT License.

## Author

- Packiyalakshmi Murugan
- [LinkedIn Link](https://www.linkedin.com/in/packiyalakshmi-m-7a9844210/)
- [Github link](https://github.com/Packiyalakshmi-M/)
