import 'package:flutter/material.dart';
import 'package:todolist/enum/platform.dart';

/// 給予裝置寬度（通常在最外層元件如 [MaterialApp]），判斷平台為電腦、平板，或手機
class PlatformViewModel {
  Platform _platform = Platform.mobile;

  Platform get platform => _platform;

  void setDeviceWidth(double width) {
    if (width >= 1280) {
      _platform = Platform.computer;
    } else if (width >= 960) {
      _platform = Platform.tablet;
    } else {
      _platform = Platform.mobile;
    }
  }
}
