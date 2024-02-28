import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_jumeoni/model/user.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class FirebaseApple {
  // MyUser curUser = MyUser();
  static Future<void> appleLogin() async {
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );

    final OAuthCredential credential = OAuthProvider('apple.com').credential(
      idToken: appleCredential.identityToken,
      accessToken: appleCredential.authorizationCode,
    );

    var result = await FirebaseAuth.instance.signInWithCredential(credential);

    print(result);
  }
}
