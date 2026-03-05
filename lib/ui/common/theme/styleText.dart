import 'package:flutter/material.dart';

const Color blackText =Colors.black;

const textTheme =TextTheme(
titleMedium: TextStyle(fontSize: 35, color: blackText)
);

extension TextStyles on BuildContext {

  TextStyle get titleMedium => Theme.of(this).textTheme.titleMedium!;

}