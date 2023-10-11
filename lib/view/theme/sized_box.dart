import 'package:flutter/material.dart';

/// 用於 [Drawer] 上的 [SizedBox]
abstract class DrawerSizedBox extends SizedBox {
  const DrawerSizedBox({
    super.key,
    super.height,
    super.width,
    super.child,
  });

  factory DrawerSizedBox.normal({Key? key}) => _DrawerSizedBox(
        key: key,
        height: 10,
      );

  factory DrawerSizedBox.avatar({Key? key, required Widget child}) =>
      _DrawerSizedBox(
        key: key,
        width: 75,
        height: 75,
        child: child,
      );
}

class _DrawerSizedBox extends DrawerSizedBox {
  const _DrawerSizedBox({super.key, super.width, super.height, super.child});
}
