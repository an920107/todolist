import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist/view/widget/user_avatar.dart';
import 'package:todolist/view_model/user_view_model.dart';

/// 尚未登入時，顯示登入按鈕；已登入時，顯示 [UserAvatar]，
/// 點擊後展開 end drawer
class SignInButton extends StatelessWidget {
  const SignInButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, value, child) {
        if (value.isLoggedIn) {
          return GestureDetector(
            onTap: () async {
              Scaffold.of(context).openEndDrawer();
            },
            child: MouseRegion(
              cursor: SystemMouseCursors.click,
              child: FractionallySizedBox(
                heightFactor: 0.7,
                child: ClipOval(
                  child: UserAvatar(photoUrl: value.photoURL),
                ),
              ),
            ),
          );
        } else {
          return FilledButton.icon(
            onPressed: () async {
              await value.signInWithGoogle();
            },
            icon: const Icon(Icons.login),
            label: const Text("Sign in"),
          );
        }
      },
    );
  }
}
