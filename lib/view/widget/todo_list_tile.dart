import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:todolist/extension/todo_extension.dart';
import 'package:todolist/model/todo.dart';
import 'package:todolist/view_model/todo_list_view_model.dart';

class TodoListTile extends StatefulWidget {
  const TodoListTile({
    super.key,
    required this.todo,
    this.clickable = true,
  });

  final Todo todo;
  final bool clickable;

  @override
  State<TodoListTile> createState() => _TodoListTileState();
}

class _TodoListTileState extends State<TodoListTile> {
  final _slidableKey = GlobalKey();

  @override
  Widget build(BuildContext context) {
    return Slidable(
      key: _slidableKey,
      startActionPane: _buildActionPane(context),
      endActionPane: _buildActionPane(context),
      child: ListTile(
        hoverColor: Colors.transparent,
        onTap: widget.clickable
            ? () =>
                context.read<TodoListViewModel>().toggleDetailed(widget.todo.id)
            : null,
        leading: Icon(
          widget.todo.isOverdue
              ? Icons.notification_important
              : (widget.todo.isDetailed
                  ? Icons.arrow_drop_down_rounded
                  : Icons.arrow_right_rounded),
          color: widget.todo.isOverdue ? Colors.red.shade400 : null,
        ),
        title: Text(widget.todo.title),
        subtitle: widget.todo.isDetailed
            ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.todo.deadline != null
                      ? DateFormat("y/M/d E HH:mm")
                          .format(widget.todo.deadline!)
                      : "Deadline was not set."),
                  if (widget.todo.isOverdue) const Text("Overdue!")
                ],
              )
            : null,
        trailing: widget.clickable && widget.todo.isDetailed
            ? IconButton(
                color: Colors.red.shade400,
                style: ButtonStyle(
                  backgroundColor: MaterialStateColor.resolveWith((states) {
                    if (states.contains(MaterialState.pressed)) {
                      return Colors.red.withOpacity(0.4);
                    } else if (states.contains(MaterialState.hovered)) {
                      return Colors.red.withOpacity(0.15);
                    } else {
                      return Colors.red.withOpacity(0.05);
                    }
                  }),
                ),
                onPressed: () => _removeTodo(context),
                icon: const Icon(Icons.delete),
              )
            : null,
      ),
    );
  }

  void _removeTodo(BuildContext context) {
    context.read<TodoListViewModel>().removeTodo(widget.todo.id);
  }

  ActionPane _buildActionPane(BuildContext context) {
    return ActionPane(
      extentRatio: 0.2,
      motion: const BehindMotion(),
      dismissible: DismissiblePane(
        closeOnCancel: true,
        dismissThreshold: 0.6,
        onDismissed: () {},
        confirmDismiss: () async {
          Future.delayed(const Duration(milliseconds: 100))
              .then((value) => _removeTodo(context));
          return false;
        },
      ),
      children: [
        SlidableAction(
          onPressed: (context) =>
              Future.delayed(const Duration(milliseconds: 150))
                  .then((value) => _removeTodo(context)),
          borderRadius: BorderRadius.circular(6),
          backgroundColor: Colors.red,
          icon: Icons.delete,
          label: "Remove",
        )
      ],
    );
  }
}
