import 'package:flutter/material.dart';
import 'package:flutter_jumeoni/model/user.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: const Center(
        child: Column(
          children: [Text("Hi")],
        ),
      ),
    );
  }
}
