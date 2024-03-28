import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'register_drink.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var curUser = FirebaseAuth.instance.currentUser;
    var email = curUser?.email;
    var userEmail = email!.substring(0, email.indexOf("@"));
    // var name = curUser?.providerData[0].displayName;
    // var storage = FirebaseStorage.instance.ref().child("drink/").listAll();
    // ListResult users = storage.listAll();

    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("drink").snapshots(),
            builder: (context, snapshot) {
              return (snapshot.connectionState == ConnectionState.waiting)
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 10,
                              crossAxisSpacing: 10,
                              childAspectRatio: 9 / 16),
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        final url = snapshot.data!.docs[index]['url'];

                        return InkWell(
                          onTap: () {
                            // var rating = snapshot.data!.docs[index]['rating'];
                            var drinkName =
                                snapshot.data!.docs[index]['drink_name'];
                            var drinkPrice =
                                snapshot.data!.docs[index]['drink_price'];
                            Get.toNamed("/detail_page", arguments: {
                              // "rating": rating,
                              "drink_name": drinkName,
                              "drink_price": drinkPrice,
                              "user_name": curUser?.email,
                            });
                          },
                          child: AspectRatio(
                            aspectRatio: 9 / 16,
                            child: Column(
                              children: [
                                Image.network(
                                  url,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                                Text(snapshot.data!.docs[index]["drink_name"]),
                              ],
                            ),
                          ),
                        );
                      },
                    );
            }));
  }
}
