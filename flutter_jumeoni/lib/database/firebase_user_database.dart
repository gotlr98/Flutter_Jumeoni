import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_jumeoni/model/user.dart';

class FirebaseUserDatabase {
  static Future<MyUser?> findUserByUid(String uid) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    QuerySnapshot data = await users.where('uid', isEqualTo: uid).get();

    if (data.size == 0) {
      return null;
    } else {
      var temp = data.docs[0].data() as Map<String, dynamic>;
      print("ssssss=$temp");
      return MyUser.fromJson(temp, data.docs[0].id);
    }
  }

  static Future<String> saveUserToFirebase(MyUser firebaseUser) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentReference drf = await users.add(firebaseUser.toMap());
    return drf.id;
  }

  static void updateLoginTime(String docId) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(docId).update({'last_login_time': DateTime.now()});
  }

  static void singOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
