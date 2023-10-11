import 'package:todolist/model/todo.dart';
import 'package:todolist/extension/nullable_date_time.dart';

extension TodoExtension on Todo {
  bool get isOverdue => deadline.compareToNullable(DateTime.now()) < 0;
}
