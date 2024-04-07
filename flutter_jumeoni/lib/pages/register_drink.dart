import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:fluttertoast/fluttertoast.dart';
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
  TextEditingController commentController = TextEditingController();
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
        TextField(
          controller: commentController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(),
            labelText: "한줄평",
          ),
        ),
        const SizedBox(height: 30),
        ElevatedButton(
            onPressed: () async {
              if (Platform.isIOS) {
                await Permission.photosAddOnly.request();
              }
              if (drinkNameController.text.isEmpty ||
                  drinkPriceController.text.isEmpty ||
                  commentController.text.isEmpty) {
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

              if (await checkExist(drinkNameController.text)) {
                return showDialog(
                    context: context,
                    builder: (BuildContext context) => AlertDialog(
                            title: const Text("Error"),
                            content: const Text("이미 존재하는 술입니다"),
                            actions: [
                              ElevatedButton(
                                  onPressed: () => Get.back(),
                                  child: const Text("닫기"))
                            ]));
              } else {
                ImagePicker picker = ImagePicker();
                var ref = FirebaseStorage.instance.ref().child(
                    "drink/${curUser?.email}_${drinkNameController.text}_${drinkPriceController.text}");
                XFile? pick =
                    await picker.pickImage(source: ImageSource.gallery);
                if (pick == null) {
                  return;
                } else {
                  File file = File(pick.path);
                  var uploadTask = ref.putFile(file);

                  final snapshot = await uploadTask.whenComplete(() => {});
                  final url = await snapshot.ref.getDownloadURL();

                  await FirebaseFirestore.instance
                      .collection("drink")
                      .doc(drinkNameController.text)
                      .set({
                    'url': url,
                    // 'rating': ratings,
                    'drink_name': drinkNameController.text,
                    'drink_price': drinkPriceController.text,
                  });

                  await FirebaseFirestore.instance
                      .collection("drink")
                      .doc(drinkNameController.text)
                      .collection("rating")
                      .doc(curUser!.email)
                      .set({
                    'rating': ratings,
                    'comment': commentController.text,
                  });
                  await FirebaseFirestore.instance
                      .collection("users")
                      .doc(curUser?.email)
                      .collection("rating")
                      .add({
                    'drink_name': drinkNameController.text,
                    'rating': ratings,
                    'comment': commentController.text,
                  });
                }

                if (Get.isBottomSheetOpen ?? false) {
                  showToast();
                  Get.offAndToNamed("/bottom_navigation");
                }
              }
            },
            child: const Text("이미지 업로드하기")),
      ],
    )));
  }

  void showToast() {
    Fluttertoast.showToast(
        msg: "등록 완료",
        gravity: ToastGravity.TOP,
        fontSize: 30,
        timeInSecForIosWeb: 1);
  }

  Future<bool> checkExist(String drinkName) async {
    bool isExist = false;
    final ex = FirebaseFirestore.instance.collection("drink");
    var check = await ex.get();
    var aa = check.docs.toList();
    for (var i in aa) {
      if (drinkName == i.data()["drink_name"]) {
        isExist = true;
      }
    }

    return isExist;
  }
}
