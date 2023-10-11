import 'package:flutter/material.dart';
import 'package:todolist/model/todo.dart';
import 'package:todolist/model/user_data.dart';
import 'package:todolist/repo/user_data_repo.dart';
import 'package:todolist/view_model/user_view_model.dart';

/// Proxy from [UserViewModel]
class UserDataViewModel with ChangeNotifier {
  UserDataViewModel(this._userViewModel) {
    syncUserDataFromRemote();
  }

  final UserViewModel _userViewModel;
  UserData? _userData;

  bool get darkmode => _userData?.darkmode ?? false;
  set darkmode(bool value) {
    _userData?.darkmode = value;
  }

  List<Todo> get todolist => _userData?.todolist ?? [];
  set todolist(List<Todo> value) {
    _userData?.todolist = value;
  }

  Future<void> syncUserDataFromRemote() async {
    if (_userViewModel.isLoggedIn) {
      _userData = await UserDataRepo.getUserData(_userViewModel.uid);
      // 如果是新用戶
      if (_userData == null) {
        _userData =
            UserData(uid: _userViewModel.uid, darkmode: false, todolist: []);
        await UserDataRepo.updateUserData(_userData!);
      }
    } else {
      _userData = null;
    }
    notifyListeners();
  }

  Future<void> updateUserDataToRemote() async {
    if (_userViewModel.isLoggedIn) {
      await UserDataRepo.updateUserData(_userData!);
    }
  }
}
