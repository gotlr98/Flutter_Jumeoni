import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection("drink").snapshots(),
        builder: (context, snapshot) {
          return (snapshot.connectionState == ConnectionState.waiting)
              ? const Center(
                  child: CircularProgressIndicator.adaptive(),
                )
              :
              // final url = snapshot.data!.docs[index]['url'];

              InkWell(
                  onTap: () {
                    var rating = snapshot.data!.docs[1]['rating'];
                    print(rating);
                  },
                  child: Column(
                    children: [
                      // Image.network(
                      //   url,
                      //   width: double.infinity,
                      //   fit: BoxFit.cover,
                      // ),
                      Text(snapshot.data!.docs[1]["drink_name"]),
                    ],
                  ),
                );
        });
  }
}