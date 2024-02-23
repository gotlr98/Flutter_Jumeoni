import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'pages/login.dart';
import 'pages/main_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: "주머니",
      getPages: [
        GetPage(name: "/", page: () => const Login()),
        GetPage(name: "/main_page", page: () => const MainPage()),
      ],
    );
  }
}
