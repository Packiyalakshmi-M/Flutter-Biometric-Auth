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
