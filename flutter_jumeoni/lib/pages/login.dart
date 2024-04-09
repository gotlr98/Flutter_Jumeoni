import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../certification/apple.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("주(酒)머니"),
            SignInWithAppleButton(
              onPressed: () async {
                if (Platform.isAndroid) {
                  Get.snackbar("Apple Sign-in Error",
                      "Apple Sign-In is not currently supported on Android devices",
                      snackPosition: SnackPosition.BOTTOM);
                } else if (Platform.isIOS) {
                  FirebaseApple.appleLogin();
                  // Get.toNamed("/main_page");
                }
              },
            ),
            ElevatedButton(
                onPressed: () {
                  FirebaseAuth.instance.signInAnonymously();
                  Get.toNamed("/bottom_navigation");
                },
                child: const Text("Guest"))
          ],
        ),
      ),
    );
  }
}
