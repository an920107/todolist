class Todo {
  String id;
  DateTime createdTime;
  String title;
  DateTime? deadline;
  bool isDetailed;

  Todo({
    required this.id,
    required this.createdTime,
    required this.title,
    this.deadline,
    this.isDetailed = false,
  });

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"],
        createdTime: DateTime.parse(json["createdTime"]),
        title: json["title"],
        deadline:
            json["deadline"] != null ? DateTime.parse(json["deadline"]) : null,
      );

  Todo copy() => Todo(id: id, createdTime: createdTime, title: title);

  Map<String, dynamic> toJson() => {
        "id": id,
        "createdTime": createdTime.toIso8601String(),
        "title": title,
        "deadline": deadline?.toIso8601String(),
      };
}
