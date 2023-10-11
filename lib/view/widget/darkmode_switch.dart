import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/view_model/darkmode_view_model.dart';

class DarkmodeSwitch extends StatelessWidget {
  const DarkmodeSwitch({super.key});

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: context.watch<DarkmodeViewModel>().brightness == Brightness.dark,
      onChanged: (value) =>
          context.read<DarkmodeViewModel>().setDarkmode(value),
      thumbIcon: MaterialStateProperty.resolveWith(
        (states) => Icon(states.contains(MaterialState.selected)
            ? Icons.dark_mode
            : Icons.light_mode),
      ),
    );
  }
}
