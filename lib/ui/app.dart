import 'package:diplom/ui/web/home_admin_panel/homeAdminPanel.dart';
import 'package:diplom/ui/web/signIn/signIn.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'mobile/home_page/home_page.dart';

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) =>
      MaterialApp(home: IsWeb());

}

class IsWeb extends StatelessWidget {
  const IsWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return SignInPage();
  }
}
