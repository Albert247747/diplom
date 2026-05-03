import 'package:diplom/ui/common/theme/colors.dart';
import 'package:diplom/utils/translations.g.dart';
import 'package:flutter/material.dart';

class NotAuthorizedMobile extends StatelessWidget {
  const NotAuthorizedMobile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: mainBackground,
      body: Center(child: Text(context.t.error.mobileRoleError)),
    );
  }
}
