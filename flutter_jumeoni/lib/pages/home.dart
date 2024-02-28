import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jumeoni/controller/profile_controller.dart';
import 'package:flutter_jumeoni/pages/login.dart';
import 'package:flutter_jumeoni/pages/main_page.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
        ProfileController.to.StateChanges(snapshot.data);
        if (!snapshot.hasData) {
          return const Login();
        } else {
          return const MainPage();
        }
      },
    );
  }
}
