import 'package:flutter/material.dart';

/// 用於 [AppBar] 上元素的 [Padding]
abstract class AppBarPadding extends Padding {
  const AppBarPadding({
    super.key,
    required super.padding,
    super.child,
  });

  factory AppBarPadding.action(
          {Key? key, Widget? child, bool isLastOne = false}) =>
      _AppBarPadding(
        key: key,
        padding: EdgeInsets.only(left: 20, right: isLastOne ? 20 : 0),
        child: child,
      );
}

class _AppBarPadding extends AppBarPadding {
  const _AppBarPadding({super.key, required super.padding, super.child});
}

/// 用於一般 Layout 上元素的 [Padding]
abstract class LayoutPadding extends Padding {
  const LayoutPadding({
    super.key,
    required super.padding,
    super.child,
  });

  factory LayoutPadding.wide({Key? key, Widget? child}) => _LayoutPadding(
        key: key,
        padding: const EdgeInsets.symmetric(
          horizontal: 60,
          vertical: 40,
        ),
        child: child,
      );

  factory LayoutPadding.narrow({Key? key, Widget? child}) => _LayoutPadding(
        key: key,
        padding: const EdgeInsets.symmetric(
          horizontal: 30,
          vertical: 20,
        ),
        child: child,
      );
}

/// 用於 [Drawer] 上元素的 [Padding]
class _LayoutPadding extends LayoutPadding {
  const _LayoutPadding({super.key, required super.padding, super.child});
}

abstract class DrawerPadding extends Padding {
  const DrawerPadding({
    super.key,
    required super.padding,
    super.child,
  });

  factory DrawerPadding.header({Key? key, required Widget child}) =>
      _DrawerPadding(
        key: key,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: child,
      );
}

class _DrawerPadding extends DrawerPadding {
  const _DrawerPadding({super.key, required super.padding, super.child});
}
