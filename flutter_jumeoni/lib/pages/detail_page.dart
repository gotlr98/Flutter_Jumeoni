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
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 6.0,
                      crossAxisSpacing: 6.0),
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    final url = snapshot.data!.docs[index]['url'];

                    return InkWell(
                      onTap: () {
                        var rating = snapshot.data!.docs[index]['rating'];
                        print(rating);
                      },
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
                    );
                  },
                );
        });
  }
}
