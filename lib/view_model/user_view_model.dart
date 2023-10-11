import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart' show kDebugMode;
import 'package:flutter/material.dart';

/// 管理使用者帳號資訊，以及登入、登出行為
class UserViewModel with ChangeNotifier {
  UserViewModel() {
    // _googleAuthProvider
    //     .addScope("https://www.googleapis.com/auth/calendar.events");
    FirebaseAuth.instance.authStateChanges().listen((user) {
      _user = user;
      notifyListeners();
    });
  }

  final GoogleAuthProvider _googleAuthProvider = GoogleAuthProvider();
  User? _user;

  bool get isLoggedIn => _user != null;
  String get uid => (_user?.uid).toString();
  String get displayName => (_user?.displayName).toString();
  String get email => (_user?.email).toString();
  String get photoURL => (_user?.photoURL).toString();

  /// 以 Google 帳號登入，回傳是否成功登入
  Future<bool> signInWithGoogle() async {
    try {
      // 以彈出式視窗登入
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithPopup(_googleAuthProvider);
      _user = userCredential.user;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
    notifyListeners();
    return true;
  }

  /// 登出帳號，回傳是否成功登出
  Future<bool> signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      _user = null;
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return false;
    }
    notifyListeners();
    return true;
  }
}
