import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    var curUser = FirebaseAuth.instance.currentUser;
    var email = curUser?.email;
    var id = email!.substring(0, email.indexOf("@"));
    var drinks = [];
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
                    title: Text("$id 리뷰"),
                  ),
                  body: Container(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // for (int i = 0; i < snapshot.data!.size; i++)
                        //   Row(
                        //     children: [
                        //       Text("$id 님의 리뷰: "),
                        //       Text(snapshot.data!.docs[i]["rating"].toString()),
                        //     ],
                        //   ),
                        ElevatedButton(
                            onPressed: () {
                              var test = snapshot.data!.docs;
                              var a = test;
                              for (var i in test) {
                                // drinks.add(i.id);
                                var id = i.id;
                                print(i);
                                // print("drinks: ${i[id]["rating"]}");
                              }
                            },
                            child: const Text("check"))
                      ],
                    ),
                  ));

          // final url = snapshot.data!.docs[index]['url'];
        });
  }
}
