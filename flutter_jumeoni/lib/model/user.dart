class MyUser {
  String name;
  String uid;
  String docId;
  DateTime createdTime;
  DateTime lastLoginTime;

  MyUser(
      {this.name = "",
      this.uid = "",
      this.docId = "",
      DateTime? createdTime,
      DateTime? lastLoginTime})
      : createdTime = createdTime ?? DateTime.now(),
        lastLoginTime = lastLoginTime ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'uid': uid,
      'docId': docId,
      'createdTime': createdTime,
      'lastLoginTime': lastLoginTime,
    };
  }

  MyUser.fromJson(Map<String, dynamic> json, String docId)
      : name = json['name'] as String,
        uid = json['uid'] as String,
        docId = docId,
        createdTime = json['createdTime'].toDate(),
        lastLoginTime = json['lastLoginTime'].toDate();
}
