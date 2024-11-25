import 'package:biometric_auth_app/App.dart';
import 'package:biometric_auth_app/Services/BiometricService/BiometricService.dart';
import 'package:biometric_auth_app/Services/BiometricService/IBiometricService.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

final GetIt getit = GetIt.instance;

void main() {
  runApp(const App());
  getit.registerSingleton<IBiometricService>(BiometricService());
}
