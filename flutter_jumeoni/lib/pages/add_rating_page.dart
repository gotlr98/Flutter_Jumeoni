import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

class AddRatingPage extends StatelessWidget {
  const AddRatingPage({super.key});

  @override
  Widget build(BuildContext context) {
    var ratings = 1.0;
    var drinkName = Get.arguments["drink_name"];
    var email = Get.arguments["email"];
    TextEditingController ratingController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back)),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "$drinkName 리뷰 남기기",
            style: const TextStyle(fontSize: 30),
          ),
          const SizedBox(
            height: 40,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
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
          const SizedBox(
            height: 30,
          ),
          TextField(
              controller: ratingController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                label: Text("평가"),
              )),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                if (ratingController.text.isEmpty) {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                              title: const Text("Error"),
                              content: const Text("이름 및 가격을 입력해주세요."),
                              actions: [
                                ElevatedButton(
                                    onPressed: () => Get.back(),
                                    child: const Text("닫기"))
                              ]));
                } else {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => AlertDialog(
                              title: const Text("등록하시겠습니까?"),
                              content: Text(
                                  "평점: $ratings \n평가: ${ratingController.text}"),
                              actions: [
                                ElevatedButton(
                                    onPressed: () async {
                                      var ratingContent =
                                          await FirebaseFirestore.instance
                                              .collection("drink")
                                              .doc(drinkName)
                                              .collection("rating")
                                              .doc(email)
                                              .set({
                                        'rating': ratings,
                                        'comment': ratingController.text,
                                      });
                                      Get.offAllNamed("main_page");
                                      print(email);
                                    },
                                    child: const Text("등록하기"))
                              ]));
                }
              },
              child: const Text("등록하기"))
        ],
      ),
    );
  }
}
