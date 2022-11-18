import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:local_auth/local_auth.dart';

import 'db_provider.dart';

class ScreenLock {
  BuildContext? ctx;
  ScreenLock({this.ctx});

  LocalAuthentication localAuth = LocalAuthentication();

  void authenticateUser({String? path, bool? value, String? message}) async {
    bool canCheckBiometrics = await localAuth.canCheckBiometrics;

    if (canCheckBiometrics == true) {
      ///Do biometrics

      //Touch ID
      // ignore: avoid_print
      print("There is fingerprint available");
      bool didAuthenticate = await localAuth.authenticate(
        localizedReason: message!,
      );

      if (path == 'splash') {
        // ignore: avoid_print
        print("Path == splash");
        if (didAuthenticate == true) {
          // ignore: avoid_print
          print("Authentication is successful");

          ///Success
          // Navigator.push(
          //     ctx!, MaterialPageRoute(builder: (context) => const HomePage()));

          ///save
        } else {
          ///Close App
          // SystemNavigator.pop();
        }
      } else {
        if (didAuthenticate == true) {
          // ignore: avoid_print
          print("Switch");

          DbProvider().saveAuthState(value!);
        }
      }
    }
  }
}
