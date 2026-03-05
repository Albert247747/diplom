import 'package:diplom/ui/common/theme/colors.dart';
import 'package:diplom/ui/common/theme/styleText.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: Center(
        child: Text(
          'домашний эран ',
          style: TextStyle(color: blackText, fontSize: 30),),
      ),
    );
  }
}
