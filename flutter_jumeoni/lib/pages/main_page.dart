import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jumeoni/model/user.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    var curUser = FirebaseAuth.instance.currentUser;
    var name = curUser?.providerData[0].displayName;
    return Scaffold(
      appBar: AppBar(
        title: Text("Hi ${curUser?.email}"),
        actions: [
          DropdownButton(
            icon: const Icon(Icons.more_vert),
            items: const [
              DropdownMenuItem(value: "1", child: Text("register"))
            ],
            onChanged: (String? newValue) {
              Get.toNamed("/register_drink");
            },
          ),
        ],
      ),
      body: const Center(
        child: Column(
          children: [],
        ),
      ),
    );
  }
}
