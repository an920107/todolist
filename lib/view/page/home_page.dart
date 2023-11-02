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
      final width = context.read<PlatformViewModel>().width;
      final double sidePadding = width > 1280 ? (width - 1280 + 40) / 2 : 20;
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          titleSpacing: 0,
          centerTitle: false,
          title: Row(children: [
            SizedBox(width: sidePadding),
            const Icon(Icons.checklist),
            AppBarPadding.title(child: const Text("TODO List")),
          ]),
          actions: [
            AppBarPadding.action(child: const DarkmodeSwitch()),
            AppBarPadding.action(child: const SignInButton()),
            SizedBox(width: sidePadding),
          ],
        ),
        endDrawer: const BaseEndDrawer(),
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: sidePadding),
          child: platform == Platform.mobile
              ? LayoutPadding.narrow(child: const TodoAnimatedList())
              : LayoutPadding.wide(child: const TodoAnimatedList()),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(horizontal: sidePadding),
          child: platform == Platform.mobile
              ? LayoutPadding.narrow(child: const TodoInput())
              : LayoutPadding.wide(child: const TodoInput()),
        ),
      );
    });
  }
}
