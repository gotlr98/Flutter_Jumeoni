import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var email = FirebaseAuth.instance.currentUser?.email ?? "guest";
    var id =
        email == "guest" ? "guest" : email.substring(0, email.indexOf("@"));
    var ratings = 1.0;
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(email)
            .collection("rating")
            .snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              : Scaffold(
                  appBar: AppBar(
                    title: id == "guest"
                        ? const Text("guest는 제공하지 않는 기능입니다")
                        : Text("$id님의 리뷰창"),
                  ),
                  body: Container(
                    padding: const EdgeInsets.all(10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        for (int i = 0; i < snapshot.data!.size; i++)
                          Container(
                            padding: const EdgeInsets.all(5),
                            decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(10)),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                    "${snapshot.data!.docs[i]["drink_name"].toString()} review: "),
                                Text(
                                    "comment: ${snapshot.data!.docs[i]["comment"].toString()}"),
                                Row(
                                  children: [
                                    const Text("ratings: "),
                                    RatingBar.builder(
                                      ignoreGestures: true,
                                      initialRating: snapshot.data!.docs[i]
                                          ["rating"],
                                      minRating: 1,
                                      direction: Axis.horizontal,
                                      allowHalfRating: true,
                                      itemCount: 5,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 2.0),
                                      itemBuilder: (context, _) => const Icon(
                                          Icons.star,
                                          color: Colors.amber),
                                      onRatingUpdate: (rating) {
                                        ratings = rating;
                                      },
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                      ],
                    ),
                  ));
        });
  }
}
