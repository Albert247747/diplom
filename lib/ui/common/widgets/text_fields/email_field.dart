import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class EmailField extends StatelessWidget {
  const EmailField({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) => TextField(
    keyboardType: TextInputType.emailAddress,
    decoration: InputDecoration(
      filled: true,
      label: Text(label),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: BorderSide(color: mainBackground),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: BorderSide(color: backgroundTextField),
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(100),
        borderSide: BorderSide(color: backgroundTextField),
      ),
    ),
  );
}
