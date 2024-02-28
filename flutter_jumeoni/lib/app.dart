import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'pages/home.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Firebase.initializeApp(),
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return Container(
            color: Colors.white,
            child: const Center(child: Text('Firebase load fail')),
          );
        }
        if (snapshot.connectionState == ConnectionState.done) {
          return const Home();
        } else {
          return Container(
              color: Colors.white,
              child: const Center(
                child: CircularProgressIndicator(),
              ));
        }
      },
    );
  }
}
