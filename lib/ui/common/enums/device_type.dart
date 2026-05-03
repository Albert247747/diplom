import 'package:flutter/foundation.dart';

enum UserPlatform { web, mobile, desktop }

class PlatformHelper {
  static UserPlatform get current {
    if (kIsWeb) return UserPlatform.web;

    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return UserPlatform.mobile;
      case TargetPlatform.iOS:
        return UserPlatform.mobile;
      case TargetPlatform.macOS:
      case TargetPlatform.windows:
      case TargetPlatform.linux:
        return UserPlatform.desktop;
      default:
        throw Exception('Unsupported platform');
    }
  }

  static bool get isWeb => current == UserPlatform.web;

  static bool get isMobile => current == UserPlatform.mobile;

  static bool get isDesktop => current == UserPlatform.desktop;
}
