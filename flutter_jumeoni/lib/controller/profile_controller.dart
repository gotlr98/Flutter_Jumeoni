import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import '../database/firebase_user_database.dart';
import '../model/user.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();
  Rx<MyUser> myuser = MyUser().obs;
  String? docId;

  void StateChanges(User? firebaseUser) async {
    MyUser? firebaseUserdata =
        await FirebaseUserDatabase.findUserByUid(firebaseUser?.uid ?? "");
    if (firebaseUserdata == null) {
      myuser.value = MyUser(
        uid: firebaseUser?.uid ?? "",
        name: firebaseUser?.displayName ?? "",
        createdTime: DateTime.now(),
        lastLoginTime: DateTime.now(),
      );
      docId = await FirebaseUserDatabase.saveUserToFirebase(myuser.value);
      myuser.value.docId = docId ?? "";
    } else {
      myuser.value = firebaseUserdata;
      FirebaseUserDatabase.updateLoginTime(firebaseUserdata.docId);
    }
  }
}
