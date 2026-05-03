import 'package:flutter/material.dart';

import '../../theme/colors.dart';

class OutlinedTextField extends StatefulWidget {
  final String? hintText;
  final String? errorText;
  final String? prefixIconPath;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool hasError;
  final IconData? showPasswordIcon;
  final TextEditingController? controller;

  const OutlinedTextField({
    super.key,
    this.hintText,
    this.errorText,
    this.prefixIconPath,
    this.keyboardType,
    this.obscureText = false,
    this.hasError = false,
    this.showPasswordIcon,
    this.controller,
  });

  @override
  State<OutlinedTextField> createState() => _OutlinedTextFieldState();
}

class _OutlinedTextFieldState extends State<OutlinedTextField> {
  late bool _obscure;

  @override
  void initState() {
    super.initState();
    _obscure = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final borderColor = widget.hasError ? errorColor : mainGreen;

    return TextField(
      controller: widget.controller,
      keyboardType: widget.keyboardType,
      obscureText: _obscure,

      decoration: InputDecoration(
        hintText: widget.hintText,
        errorText: widget.hasError ? widget.errorText : null,

        isDense: true,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        prefixIcon: widget.prefixIconPath != null
            ? Padding(
          padding: const EdgeInsets.all(10),
          child: Image.asset(
            widget.prefixIconPath!,
            width: 20,
            height: 20,
          ),
        )
            : null,
        suffixIcon: widget.showPasswordIcon != null
            ? IconButton(
          icon: Icon(widget.showPasswordIcon),
          onPressed: () {
            setState(() {
              _obscure = !_obscure;
            });
          },
        )
            : null,

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor),
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(color: borderColor, width: 1),
        ),

        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorColor),
        ),

        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: errorColor, width: 1),
        ),
      ),
    );
  }
}