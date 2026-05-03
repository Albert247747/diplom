import 'package:diplom/utils/translations.g.dart';
import 'package:flutter/material.dart';

class ErrorScreenWeb extends StatelessWidget {
  const ErrorScreenWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text(context.t.error.webAuthorizationError)),
    );
  }
}
