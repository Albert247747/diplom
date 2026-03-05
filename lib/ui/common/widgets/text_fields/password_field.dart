import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({
    required this.label,
    super.key
  });

  final String label;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {
  bool _obscureText  = true;
  @override
  Widget build(BuildContext context) => TextField(
    decoration: InputDecoration(
      filled: true,
      label: Text(widget.label),
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
      suffix: GestureDetector(
        onTap: ( ){
          setState(() {
            _obscureText = !_obscureText;
          });
        },
        child: Text(
          _obscureText ? 'Показать' : 'Закрыть',
          style: TextStyle(
            color: greenText
          ),
        ),
      )
    ),
  );
}
