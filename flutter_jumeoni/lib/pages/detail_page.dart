import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    // var email = Get.arguments["user_name"];
    // var userEmail = email.substring(0, email.indexOf("@"));
    var drinkName = Get.arguments["drink_name"];
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("drink")
            .doc(drinkName)
            .collection("rating")
            .snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Scaffold(
                  appBar: AppBar(
                    title: Text("$drinkName 리뷰"),
                    leading: IconButton(
                        onPressed: () {
                          Get.back();
                        },
                        icon: const Icon(Icons.arrow_back)),
                    actions: [
                      IconButton(
                          onPressed: () {
                            Get.toNamed("/add_rating_page", arguments: {
                              // "email": email,
                              "drink_name": drinkName
                            });
                          },
                          icon: const Icon(Icons.add))
                    ],
                  ),
                  body: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < snapshot.data!.size; i++)
                          Column(
                            children: [
                              Text("${snapshot.data!.docs[i].id}님 - "),
                              Text(
                                  "comment: ${snapshot.data!.docs[i]["comment"].toString()}"),
                              Text(
                                  "rating: ${snapshot.data!.docs[i]["rating"].toString()}"),
                            ],
                          ),
                      ],
                    ),
                  ));

          // final url = snapshot.data!.docs[index]['url'];
        });
  }
}
