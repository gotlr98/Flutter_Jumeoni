import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_jumeoni/model/user.dart';
import 'package:get/get.dart';

import 'register_drink.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final storage = FirebaseStorage.instance.ref().child("drink/");
    var curUser = FirebaseAuth.instance.currentUser;
    var name = curUser?.providerData[0].displayName;
    var users = storage.listAll();
    var allFileList = for i in users{storage.child("$users");}
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
                // Get.toNamed("/register_drink");
                showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (BuildContext context) {
                      return SizedBox(
                          height: MediaQuery.of(context).size.height * 0.7,
                          child: const RegisterDrink());
                    });
              },
            ),
          ],
        ),
        body: GridView.builder(
          scrollDirection: Axis.vertical,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, //1 개의 한 행에 보여줄 개수
            childAspectRatio: 1 / 1, //item 의 가로, 세로 비율
            mainAxisSpacing: 0, //수평 Padding
            crossAxisSpacing: 0,
          ), //📲수직 Padding),)
          itemCount: 1,
          itemBuilder: (context, index) {
            return const Center();
          },
        ));
  }
}
