import 'package:todolist/model/todo.dart';

class UserData {
  String uid;
  bool darkmode;
  List<Todo> todolist;

  UserData({
    required this.uid,
    required this.darkmode,
    required this.todolist,
  });

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        uid: json["uid"],
        darkmode: json["darkmode"],
        todolist:
            List<Todo>.from(json["todolist"].map((x) => Todo.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "darkmode": darkmode,
        "todolist": List<dynamic>.from(todolist.map((x) => x.toJson())),
      };
}
