import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import 'main_page.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("주머니 로그인"),
          backgroundColor: const Color.fromARGB(0, 117, 50, 184),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("주(酒)머니", style: TextStyle(fontSize: 50)),
              const Spacer(
                flex: 1,
              ),
              SignInWithAppleButton(
                onPressed: () async {
                  final credential = await SignInWithApple.getAppleIDCredential(
                    scopes: [
                      AppleIDAuthorizationScopes.email,
                      AppleIDAuthorizationScopes.fullName,
                    ],
                  );
                  print("${credential.familyName}+${credential.givenName}");
                  Get.toNamed("/mainpage/email=$credential.email");
                },
              ),
              ElevatedButton(
                  onPressed: () {
                    Get.toNamed("/main_page", arguments: {"name": "guest"});
                  },
                  child: const Text("Guest Login")),
            ],
          ),
        ));
  }
}
