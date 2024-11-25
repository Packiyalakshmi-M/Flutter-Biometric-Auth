import 'package:biometric_auth_app/Pages/HomeScreen/HomeScreen.dart';
import 'package:biometric_auth_app/Services/BiometricService/IBiometricService.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_it/get_it.dart';
import 'package:local_auth/local_auth.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  // Create an instance for IBiometricService
  final IBiometricService _biometricService =
      GetIt.instance<IBiometricService>();

  bool isBiometricsAvailable = false;
  bool canCheckBiometrics = false;
  bool authenticated = false;

  void _checkForBiometricAvailability() async {
    try {
      await _biometricService.isBiometricsAvailable().then(
            (bool isAvailable) => setState(
              () {
                isBiometricsAvailable = isAvailable;
              },
            ),
          );
      await _biometricService.canCheckBiometricsAuth().then(
            (bool canCheck) => setState(
              () {
                canCheckBiometrics = canCheck;
              },
            ),
          );
    } catch (ex) {
      print("Exception: ${ex.toString()}");
    }
  }

  @override
  void initState() {
    super.initState();
    _checkForBiometricAvailability();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Biometric authentication"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            !isBiometricsAvailable && !canCheckBiometrics
                ? const Text('Biometrics not available in this device')
                : Column(
                    children: [
                      TextButton(
                        onPressed: () async {
                          authenticated =
                              await _biometricService.authenticateAnyway();
                          if (authenticated) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          }
                        },
                        child: const Text("Authenticate anyway"),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () async {
                          authenticated = await _biometricService
                              .authenticateWithBiometrics();
                          if (authenticated) {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => const HomeScreen(),
                              ),
                            );
                          }
                        },
                        child: const Text("Authenticate with Biometrics only"),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
