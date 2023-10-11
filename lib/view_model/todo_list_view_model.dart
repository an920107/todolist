import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:todolist/extension/nullable_date_time.dart';
import 'package:todolist/model/todo.dart';
import 'package:todolist/view_model/user_data_view_model.dart';
import 'package:uuid/uuid.dart';

/// Proxy from [UserDataViewModel]
class TodoListViewModel with ChangeNotifier {
  TodoListViewModel(this._userDataViewModel) {
    _todolistMap.addAll({for (var x in _userDataViewModel.todolist) x.id: x});
  }

  final UserDataViewModel _userDataViewModel;

  final Map<String, Todo> _todolistMap = HashMap();

  List<Todo> get todolist => List<Todo>.from(_todolistMap.values)
    ..sort((a, b) => a.deadline.compareToNullable(b.deadline));

  Future<void> createTodo(String title, DateTime? deadline) async {
    final id = const Uuid().v1();
    final todo = Todo(
      id: id,
      createdTime: DateTime.now(),
      title: title,
      deadline: deadline,
    );
    _todolistMap[id] = todo;
    notifyListeners();

    _userDataViewModel.todolist = todolist;
    await _userDataViewModel.updateUserDataToRemote();
  }

  Future<void> removeTodo(String id) async {
    _todolistMap.remove(id);
    notifyListeners();

    _userDataViewModel.todolist = todolist;
    await _userDataViewModel.updateUserDataToRemote();
  }

  Future<void> removeAllTodos() async {
    _todolistMap.clear();
    notifyListeners();

    _userDataViewModel.todolist = todolist;
    await _userDataViewModel.updateUserDataToRemote();
  }

  void toggleDetailed(String id) {
    if (!_todolistMap[id]!.isDetailed) {
      for (var todo in _todolistMap.values) {
        todo.isDetailed = false;
      }
    }
    _todolistMap[id]!.isDetailed = !_todolistMap[id]!.isDetailed;
    notifyListeners();
  }
}
