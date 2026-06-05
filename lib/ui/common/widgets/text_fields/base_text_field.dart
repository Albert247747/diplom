import 'package:flutter/material.dart';
import '../../theme/colors.dart';

class BaseTextFieldWidget extends StatefulWidget {
  const BaseTextFieldWidget({
    this.hintText,
    this.errorText,
    this.prefixIconPath,
    this.keyboardType,
    this.obscureText = false,
    this.hasError = false,
    this.showPasswordIcon,
    this.controller,
    super.key,
  });

  final String? hintText;
  final String? errorText;
  final String? prefixIconPath;
  final TextInputType? keyboardType;
  final bool obscureText;
  final bool hasError;
  final IconData? showPasswordIcon;
  final TextEditingController? controller;

  @override
  State<BaseTextFieldWidget> createState() => _BaseTextFieldWidgetState();
}

class _BaseTextFieldWidgetState extends State<BaseTextFieldWidget> {
  bool _obscureText = false;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      keyboardType: widget.keyboardType,
      obscureText: _obscureText,
      controller: widget.controller,
      decoration: InputDecoration(
        filled: true,
        fillColor: widget.hasError ? redColor : null,
        enabledBorder:
            widget.hasError ? _buildErrorBorder(context, redColor) : null,
        focusedBorder:
            widget.hasError ? _buildErrorBorder(context, redColor) : null,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(100),
          borderSide: BorderSide(color: whiteColor),
        ),
        hintText: widget.hintText,
        errorText: widget.errorText,
        prefixIcon:
            widget.prefixIconPath != null
                ? IconButton(
                  onPressed: () {},
                  icon: Image.asset(widget.prefixIconPath!),
                )
                : null,
        suffixIcon:
            widget.obscureText
                ? IconButton(
                  icon: Icon(
                    _obscureText
                        ? (widget.showPasswordIcon ?? Icons.visibility_off)
                        : (widget.showPasswordIcon ?? Icons.visibility),
                    color: greenColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                )
                : null,
      ),
    );
  }

  InputBorder _buildErrorBorder(BuildContext context, Color borderColor) {
    final themeBorder = Theme.of(context).inputDecorationTheme.border;
    final borderSide = BorderSide(color: borderColor);
    if (themeBorder is OutlineInputBorder) {
      return themeBorder.copyWith(borderSide: borderSide);
    }
    if (themeBorder is UnderlineInputBorder) {
      return themeBorder.copyWith(borderSide: borderSide);
    }
    return OutlineInputBorder(borderSide: borderSide);
  }
}
