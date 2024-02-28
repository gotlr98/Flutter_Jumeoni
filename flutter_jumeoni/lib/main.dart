import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jumeoni/controller/profile_controller.dart';
import 'package:get/get.dart';

import 'app.dart';
import 'pages/login.dart';
import 'pages/main_page.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      initialBinding: BindingsBuilder(() {
        Get.lazyPut<ProfileController>(() => ProfileController());
      }),
      getPages: [
        GetPage(name: "/", page: () => const Login()),
        GetPage(name: "/main_page", page: () => const MainPage()),
      ],
      home: const App(),
    );
  }
}
