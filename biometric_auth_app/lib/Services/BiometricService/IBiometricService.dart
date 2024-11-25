import 'package:local_auth/local_auth.dart';

abstract class IBiometricService {
  Future<bool> isBiometricsAvailable();
  Future<bool> canCheckBiometricsAuth();
  Future<List<BiometricType>> getAvailableBiometricOptions();
  Future<bool> authenticateAnyway();
  Future<bool> authenticateWithBiometrics();
  Future<bool> cancelAuthentication();
}
