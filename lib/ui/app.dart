import 'package:flutter/material.dart';
import 'common/auth_gate/auth_gate.dart';
import 'common/enums/device_type.dart';
import 'common/theme/style_text.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    final platform = PlatformHelper.current;
    return MaterialApp(
      theme: ThemeData(textTheme: textTheme),
      home: AppEntry(platform: platform),
    );
  }
}

class AppEntry extends StatelessWidget {
  final UserPlatform platform;

  const AppEntry({super.key, required this.platform});

  @override
  Widget build(BuildContext context) {
    return AuthGate(platform: platform);
  }
}
