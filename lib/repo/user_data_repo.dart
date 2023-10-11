import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todolist/model/user_data.dart';

class UserDataRepo {
  static final _db = FirebaseFirestore.instance;

  static Future<UserData?> getUserData(String uid) async {
    try {
      final doc = await _db.collection("user_data").doc(uid).get();
      return UserData.fromJson(doc.data()!);
    } on TypeError {
      return null;
    }
  }

  static Future<void> updateUserData(UserData userData) async {
    await _db.collection("user_data").doc(userData.uid).set(userData.toJson());
  }
}
