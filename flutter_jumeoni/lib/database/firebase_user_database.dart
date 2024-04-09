import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_jumeoni/model/user.dart';

class FirebaseUserDatabase {
  static Future<MyUser?> findUserByUid(String uid) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    QuerySnapshot data = await users.where('uid', isEqualTo: uid).get();

    if (data.size == 0) {
      return null;
    } else {
      var temp = data.docs[0].data() as Map<String, dynamic>;
      return MyUser.fromJson(temp);
    }
  }

  static Future saveUserToFirebase(MyUser firebaseUser) async {
    var email = firebaseUser.email;
    var uid = firebaseUser.uid;
    var createdTime = firebaseUser.createdTime;
    var lastLoginTime = firebaseUser.lastLoginTime;
    await FirebaseFirestore.instance.collection('users').doc(email).set({
      'email': email,
      'uid': uid,
      'createdTime': createdTime,
      'lastLoginTime': lastLoginTime,
    }, SetOptions(merge: true));
  }

  static void updateLoginTime(String? email) {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    users.doc(email).update({'lastLoginTime': DateTime.now()});
  }

  static void singOut() async {
    await FirebaseAuth.instance.signOut();
  }

  static Future<ListResult> getImageList(String email) async {
    ListResult storage =
        await FirebaseStorage.instance.ref().child("drink").listAll();
    // for (var i in storage.items){
    //   storage.e(await i.getDownloadURL());
    // }
    // List<String> url = await storage.getDownloadURL();
    return storage;
  }
}
