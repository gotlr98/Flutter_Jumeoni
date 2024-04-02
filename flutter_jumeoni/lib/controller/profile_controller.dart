import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../database/firebase_user_database.dart';
import '../model/user.dart';

class ProfileController extends GetxController {
  static ProfileController get to => Get.find();
  Rx<MyUser> myuser = MyUser().obs;

  void StateChanges(User? firebaseUser) async {
    MyUser? firebaseUserdata =
        await FirebaseUserDatabase.findUserByUid(firebaseUser?.uid ?? "");
    if (firebaseUserdata == null) {
      myuser.value = MyUser(
        uid: firebaseUser?.uid ?? " ",
        email: firebaseUser?.email ?? " ",
        createdTime: DateTime.now(),
        lastLoginTime: DateTime.now(),
      );
      await FirebaseUserDatabase.saveUserToFirebase(myuser.value);
    } else {
      myuser.value = firebaseUserdata;
      FirebaseUserDatabase.updateLoginTime(firebaseUser?.email);
    }
  }
}
