enum LoginState { loggedIn, guest }

class MyUser {
  String email;
  String uid;
  // LoginState logged;
  DateTime createdTime;
  DateTime lastLoginTime;

  MyUser(
      {this.email = "",
      this.uid = "",
      DateTime? createdTime,
      DateTime? lastLoginTime})
      : createdTime = createdTime ?? DateTime.now(),
        lastLoginTime = lastLoginTime ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'uid': uid,
      'createdTime': createdTime,
      'lastLoginTime': lastLoginTime,
    };
  }

  MyUser.fromJson(Map<String, dynamic> json)
      : email = json['email'] as String,
        uid = json['uid'] as String,
        createdTime = json['createdTime'].toDate(),
        lastLoginTime = json['lastLoginTime'].toDate();
}
