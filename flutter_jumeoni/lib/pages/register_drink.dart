import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class RegisterDrink extends StatefulWidget {
  const RegisterDrink({super.key});

  @override
  State<RegisterDrink> createState() => _RegisterDrinkState();
}

class _RegisterDrinkState extends State<RegisterDrink> {
  List<String> menuList = ["막걸리", "증류주"];
  TextEditingController drinkNameController = TextEditingController();
  TextEditingController drinkPriceController = TextEditingController();
  var curUser = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    String dropDownValue = "막걸리";
    return Scaffold(
        body: Center(
            child: Column(
      children: [
        const SizedBox(height: 20),
        DropdownButton(
            value: dropDownValue,
            items: menuList.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
            onChanged: (String? value) {
              setState(() {
                dropDownValue = value!.toString();
              });
            }),
        TextField(
          controller: drinkNameController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            label: Text("술 이름"),
          ),
        ),
        const SizedBox(
          height: 40,
        ),
        TextField(
          controller: drinkPriceController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "가격",
          ),
        ),
        ElevatedButton(
            onPressed: () async {
              if (Platform.isIOS) {
                await Permission.photosAddOnly.request();
              }

              if (drinkNameController.text.isEmpty ||
                  drinkPriceController.text.isEmpty) {
                return showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                            title: const Text("Error"),
                            content: const Text("이름 및 가격을 입력해주세요."),
                            actions: [
                              ElevatedButton(
                                  onPressed: () => Get.back(),
                                  child: const Text("닫기"))
                            ]));
              }

              ImagePicker picker = ImagePicker();
              XFile? pick = await picker.pickImage(source: ImageSource.gallery);
              if (pick != null) {
                File file = File(pick.path);
                FirebaseStorage.instance
                    .ref(
                        "drink/${curUser?.email}/${drinkNameController.text}_${drinkPriceController.text}")
                    .putFile(file);
              }
              showDialog(
                  context: context,
                  builder: (BuildContext context) => AlertDialog(
                          title: const Text("성공"),
                          content: const Text("등록 완료되었습니다"),
                          actions: [
                            ElevatedButton(
                              onPressed: () => Get.back(),
                              child: const Text("닫기"),
                            )
                          ]));
              Get.back();
            },
            child: const Text("이미지 업로드하기"))
      ],
    )));
  }
}
