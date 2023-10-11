import 'package:flutter/material.dart';
import 'package:todolist/view_model/user_data_view_model.dart';

/// Proxy from [UserDataViewModel]
class DarkmodeViewModel with ChangeNotifier {
  DarkmodeViewModel(this._userDataViewModel) {
    _darkmode = _userDataViewModel.darkmode;
  }

  final UserDataViewModel _userDataViewModel;
  bool _darkmode = false;

  Brightness get brightness => _darkmode ? Brightness.dark : Brightness.light;

  Future<void> setDarkmode(bool value) async {
    _darkmode = value;
    notifyListeners();

    _userDataViewModel.darkmode = value;
    await _userDataViewModel.updateUserDataToRemote();
  }
}
