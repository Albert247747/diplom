import 'package:diplom/ui/common/theme/colors.dart';
import 'package:flutter/material.dart';

const textTheme = TextTheme(
  titleMedium: TextStyle(fontSize: 35, color: blackColor),
  bodyMedium: TextStyle(fontSize: 16, color: blackColor),
  titleSmall: TextStyle(fontSize: 14, color: blackColor),
);

TextTheme createTextTheme(Color textColor) {
  return TextTheme(
    titleMedium: TextStyle(fontSize: 35, color: textColor),
    bodyMedium: TextStyle(fontSize: 16, color: textColor),
    titleSmall: TextStyle(fontSize: 14, color: textColor),
  );
}

extension TextStyles on BuildContext {
  TextStyle get titleMedium => Theme.of(this).textTheme.titleMedium!;

  TextStyle get bodyMedium => Theme.of(this).textTheme.bodyMedium!;

  TextStyle get titleSmall => Theme.of(this).textTheme.titleSmall!;
}
