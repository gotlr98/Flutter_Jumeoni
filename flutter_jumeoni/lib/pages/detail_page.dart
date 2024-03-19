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
              : Stack(
                  children: [
                    for (int i = 0; i < snapshot.data!.size; i++)
                      Container(
                        alignment: Alignment.center,
                        child:
                            Text(snapshot.data!.docs[i]["rating"].toString()),
                      )
                  ],
                );
          // final url = snapshot.data!.docs[index]['url'];
        });
  }
}
