import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // var curUser = FirebaseAuth.instance.currentUser;
    // var email = curUser?.email;

    return Scaffold(
        body: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection("drink").snapshots(),
            builder: (context, snapshot) {
              return (snapshot.connectionState == ConnectionState.waiting)
                  ? const Center(
                      child: CircularProgressIndicator.adaptive(),
                    )
                  : SingleChildScrollView(
                      child: Column(
                        children: [
                          GridView.builder(
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            gridDelegate:
                                const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 5,
                                    mainAxisExtent: 256),
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
                                    // "user_name": email,
                                  });
                                },
                                child: AspectRatio(
                                  aspectRatio: 9 / 16,
                                  child: Column(
                                    children: [
                                      const SizedBox(height: 5),
                                      Expanded(
                                        child: Image.network(
                                          url,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      Text(snapshot.data!.docs[index]
                                          ["drink_name"]),
                                      const SizedBox(height: 5)
                                    ],
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
            }));
  }
}
