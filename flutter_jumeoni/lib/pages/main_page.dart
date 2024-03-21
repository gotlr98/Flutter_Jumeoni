import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_jumeoni/model/user.dart';
import 'package:get/get.dart';

import '../database/firebase_user_database.dart';
import 'register_drink.dart';

class MainPage extends StatelessWidget {
  const MainPage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    var curUser = FirebaseAuth.instance.currentUser;
    // var name = curUser?.providerData[0].displayName;
    var storage = FirebaseStorage.instance.ref().child("drink/").listAll();
    // ListResult users = storage.listAll();

    return Scaffold(
        appBar: AppBar(
          title: Text("Hi ${curUser?.email}"),
          actions: [
            DropdownButton(
              icon: const Icon(Icons.more_vert),
              items: const [
                DropdownMenuItem(value: "1", child: Text("register"))
              ],
              onChanged: (String? newValue) {
                Get.bottomSheet(SingleChildScrollView(
                  child: SizedBox(
                      height: MediaQuery.of(context).size.height * 0.7,
                      child: const RegisterDrink()),
                ));
              },
            ),
          ],
        ),
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
                              mainAxisSpacing: 6.0,
                              crossAxisSpacing: 6.0),
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
                          child: SingleChildScrollView(
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
