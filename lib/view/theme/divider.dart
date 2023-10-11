import 'package:flutter/material.dart';

/// 用於 [Drawer] 中的 [Divider]
abstract class DrawerDivider extends Divider {
  const DrawerDivider({
    super.key,
    super.indent,
    super.endIndent,
    super.height,
  });

  factory DrawerDivider.normal({Key? key}) => _DrawerDivider(
        key: key,
        indent: 20,
        endIndent: 20,
        height: 20,
      );
}

class _DrawerDivider extends DrawerDivider {
  const _DrawerDivider(
      {super.key, super.indent, super.endIndent, super.height});
}
