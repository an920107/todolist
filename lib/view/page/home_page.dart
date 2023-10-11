import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/enum/platform.dart';
import 'package:todolist/view/theme/padding.dart';
import 'package:todolist/view/widget/base_end_drawer.dart';
import 'package:todolist/view/widget/darkmode_switch.dart';
import 'package:todolist/view/widget/sign_in_button.dart';
import 'package:todolist/view/widget/todo_animated_list.dart';
import 'package:todolist/view/widget/todo_input.dart';
import 'package:todolist/view_model/platform_view_model.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final platform = context.read<PlatformViewModel>().platform;
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          leading: const Icon(Icons.checklist),
          actions: [
            AppBarPadding.action(child: const DarkmodeSwitch()),
            AppBarPadding.action(isLastOne: true, child: const SignInButton()),
          ],
          title: const Text("TODO List"),
        ),
        endDrawer: const BaseEndDrawer(),
        body: platform == Platform.mobile
            ? LayoutPadding.narrow(child: const TodoAnimatedList())
            : LayoutPadding.wide(child: const TodoAnimatedList()),
        bottomNavigationBar: platform == Platform.mobile
            ? LayoutPadding.narrow(child: const TodoInput())
            : LayoutPadding.wide(child: const TodoInput()),
      );
    });
  }
}
