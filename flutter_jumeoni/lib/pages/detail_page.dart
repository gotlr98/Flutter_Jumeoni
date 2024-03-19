import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
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
              :
              // final url = snapshot.data!.docs[index]['url'];

              Scaffold(
                  body: InkWell(
                    onTap: () {
                      print(Get.arguments["drink_name"]);
                    },
                    child: Column(
                      children: [
                        Text(Get.arguments["drink_name"]),
                        Text(snapshot.data!.docs[0]["rating"].toString()),
                      ],
                    ),
                  ),
                );
        });
  }
}
