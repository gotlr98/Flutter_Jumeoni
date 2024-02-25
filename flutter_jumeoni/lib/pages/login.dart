import 'package:flutter/material.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("주(酒)머니"),
            SignInWithAppleButton(
              onPressed: () async {
                final credential = await SignInWithApple.getAppleIDCredential(
                  scopes: [
                    AppleIDAuthorizationScopes.email,
                    AppleIDAuthorizationScopes.fullName,
                  ],
                );

                print(credential);

                // Now send the credential (especially `credential.authorizationCode`) to your server to create a session
                // after they have been validated with Apple (see `Integration` section for more information on how to do this)
              },
            )
          ],
        ),
      ),
    );
  }
}
