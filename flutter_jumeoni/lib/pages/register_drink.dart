import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
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
  var ratings = 1.0;
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
        const SizedBox(height: 20),
        Row(
          children: [
            const SizedBox(
              width: 10,
            ),
            const Text("평점: "),
            RatingBar.builder(
              initialRating: 1,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemPadding: const EdgeInsets.symmetric(horizontal: 2.0),
              itemBuilder: (context, _) =>
                  const Icon(Icons.star, color: Colors.amber),
              onRatingUpdate: (rating) {
                ratings = rating;
              },
            ),
          ],
        ),
        const SizedBox(height: 30),
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
              var ref = FirebaseStorage.instance.ref().child(
                  "drink/${curUser?.email}_${drinkNameController.text}_${drinkPriceController.text}");
              XFile? pick = await picker.pickImage(source: ImageSource.gallery);
              if (pick != null) {
                File file = File(pick.path);
                var uploadTask = ref.putFile(file);

                final snapshot = await uploadTask.whenComplete(() => {});
                final url = await snapshot.ref.getDownloadURL();

                var result = await FirebaseFirestore.instance
                    .collection("drink")
                    .doc(drinkNameController.text)
                    .set({
                  'url': url,
                  // 'rating': ratings,
                  'drink_name': drinkNameController.text,
                  'drink_price': drinkPriceController.text,
                });
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
