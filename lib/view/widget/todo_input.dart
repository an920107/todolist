import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/view_model/todo_list_view_model.dart';

class TodoInput extends StatefulWidget {
  const TodoInput({super.key, this.animatedListKey});

  final GlobalKey<AnimatedListState>? animatedListKey;

  @override
  State<TodoInput> createState() => _TodoInputState();
}

class _TodoInputState extends State<TodoInput> {
  final _textController = TextEditingController();
  final _focusNode = FocusNode();
  DateTime? _pickedDateTime;

  @override
  void dispose() {
    _textController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: TextField(
              controller: _textController,
              autofocus: true,
              focusNode: _focusNode,
              onSubmitted: (value) => _submit(),
              decoration: const InputDecoration(
                hintText: "Type something",
              ),
            ),
          ),
          const SizedBox(width: 20),
          IconButton(
            color: _pickedDateTime != null
                ? Theme.of(context).colorScheme.primary
                : null,
            style: _pickedDateTime != null
                ? ButtonStyle(
                    backgroundColor: MaterialStateColor.resolveWith((states) {
                      if (states.contains(MaterialState.pressed)) {
                        return Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.4);
                      } else if (states.contains(MaterialState.hovered)) {
                        return Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.2);
                      } else {
                        return Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.1);
                      }
                    }),
                  )
                : null,
            onPressed: () async {
              DateTime? date;
              date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime.now(),
                lastDate: DateTime(DateTime.now().year + 2),
                helpText: "Select deadline date",
              );
              TimeOfDay? time;
              if (context.mounted && date != null) {
                time = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                  helpText: "Select deadline time",
                );
              }
              setState(
                () => _pickedDateTime = (date != null && time != null)
                    ? DateTime(
                        date.year, date.month, date.day, time.hour, time.minute)
                    : null,
              );
            },
            icon: const Icon(Icons.calendar_month),
          ),
          const SizedBox(width: 20),
          IconButton.filledTonal(
            iconSize: 40,
            onPressed: _submit,
            icon: const Icon(Icons.add),
          )
        ],
      ),
    );
  }

  void _submit() {
    if (_textController.text.isNotEmpty) {
      context
          .read<TodoListViewModel>()
          .createTodo(_textController.text, _pickedDateTime);
      _textController.clear();
      _focusNode.requestFocus();
      setState(() => _pickedDateTime = null);
    }
  }
}
