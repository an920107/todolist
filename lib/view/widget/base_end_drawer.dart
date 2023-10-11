import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/view/theme/padding.dart';
import 'package:todolist/view/theme/sized_box.dart';
import 'package:todolist/view/widget/user_avatar.dart';
import 'package:todolist/view_model/todo_list_view_model.dart';
import 'package:todolist/view_model/user_view_model.dart';

/// 帳號相關 Drawer，有登入才會顯示
class BaseEndDrawer extends StatelessWidget {
  const BaseEndDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Consumer<UserViewModel>(
        builder: (context, value, child) => SingleChildScrollView(
          child: Column(
            children: [
              DrawerPadding.header(
                child: DrawerHeader(
                  child: Align(
                    alignment: Alignment.bottomLeft,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        DrawerSizedBox.avatar(
                          child: ClipOval(
                            child: UserAvatar(photoUrl: value.photoURL),
                          ),
                        ),
                        DrawerSizedBox.normal(),
                        Text(value.displayName),
                        Text(value.email),
                      ],
                    ),
                  ),
                ),
              ),
              ListTile(
                onTap: () {
                  context.read<TodoListViewModel>().removeAllTodos();
                  Scaffold.of(context).closeEndDrawer();
                },
                leading: const Icon(Icons.delete_sweep),
                title: const Text("Remove all TODOs"),
              ),
              ListTile(
                onTap: () {
                  Navigator.pop(context);
                  value.signOut();
                },
                leading: const Icon(Icons.logout),
                title: const Text("Sign out"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
