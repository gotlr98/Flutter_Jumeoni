import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    var temp = Get.arguments["user_name"];
    var userEmail = temp.substring(0, temp.indexOf("@"));
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("drink")
            .doc(Get.arguments["drink_name"])
            .collection("rating")
            .snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Scaffold(
                  appBar: AppBar(
                    leading: ElevatedButton(
                        onPressed: () {
                          Get.back();
                        },
                        child: const Icon(Icons.arrow_back)),
                  ),
                  body: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < snapshot.data!.size; i++)
                          Row(
                            children: [
                              Text("$userEmail 님의 리뷰: "),
                              Text(snapshot.data!.docs[i]["rating"].toString()),
                            ],
                          ),
                      ],
                    ),
                  ));

          // final url = snapshot.data!.docs[index]['url'];
        });
  }
}
