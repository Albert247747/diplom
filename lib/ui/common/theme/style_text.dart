import 'package:flutter/material.dart';

const Color blackText = Colors.black;

const textTheme = TextTheme(
  titleMedium: TextStyle(fontSize: 35, color: blackText),
  bodyMedium: TextStyle(fontSize: 16, color:  blackText),
  titleSmall: TextStyle(fontSize: 14, color:  blackText),
);

extension TextStyles on BuildContext {
  TextStyle get titleMedium => Theme.of(this).textTheme.titleMedium!;

  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!;

  TextStyle get titleSmall => Theme.of(this).textTheme.titleSmall!;
}
