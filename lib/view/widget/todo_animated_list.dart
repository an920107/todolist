import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/model/todo.dart';
import 'package:todolist/view/widget/todo_list_tile.dart';
import 'package:todolist/view_model/todo_list_view_model.dart';

class TodoAnimatedList extends StatefulWidget {
  const TodoAnimatedList({super.key});

  @override
  State<TodoAnimatedList> createState() => _TodoAnimatedListState();
}

class _TodoAnimatedListState extends State<TodoAnimatedList> {
  final _listKey = GlobalKey<AnimatedListState>();
  List<Todo> _lastTodoList = [];

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoListViewModel>(
      builder: (context, value, child) {
        final todolist = value.todolist;

        bool insertFlag = false, removeFlag = false;
        for (int i = 0; i < todolist.length; i++) {
          if (!_lastTodoList.contains(todolist[i])) {
            _listKey.currentState?.insertItem(i);
            insertFlag = true;
          }
        }
        for (int i = _lastTodoList.length - 1; i >= 0; i--) {
          if (!todolist.contains(_lastTodoList[i])) {
            final toRemove = _lastTodoList[i].copy();
            _listKey.currentState?.removeItem(
              i,
              (context, animation) => _animationBuilder(
                animation: animation,
                child: TodoListTile(
                  clickable: false,
                  todo: toRemove,
                ),
              ),
            );
            removeFlag = true;
          }
        }

        if (removeFlag && todolist.isEmpty) {
          _listKey.currentState?.insertItem(0);
        }
        if (insertFlag && _lastTodoList.isEmpty) {
          _listKey.currentState?.removeItem(
            0,
            (context, animation) => _animationBuilder(
              animation: animation,
              child: _emptyText,
            ),
          );
        }

        _lastTodoList = List.from(todolist);

        return AnimatedList(
          key: _listKey,
          initialItemCount: todolist.isEmpty ? 1 : todolist.length,
          itemBuilder: (context, index, animation) {
            if (todolist.isEmpty) {
              return _emptyText;
            } else {
              return Column(
                children: [
                  _animationBuilder(
                    animation: animation,
                    child: TodoListTile(
                      todo: todolist[index],
                    ),
                  ),
                  if (index < todolist.length - 1) const Divider(),
                ],
              );
            }
          },
        );
      },
    );
  }

  final Text _emptyText = const Text("There is nothing TODO!");

  Widget _animationBuilder({
    required Animation<double> animation,
    required Widget child,
  }) {
    return SizeTransition(
      sizeFactor: animation,
      child: FadeTransition(
        opacity: animation,
        child: child,
      ),
    );
  }
}
