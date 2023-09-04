import 'package:flutter/material.dart';

class CommonTextForm extends StatelessWidget {
  final void Function(String)? onChanged;
  final Color borderColor;
  final TextEditingController controller;
  final bool? obscureText;
  final String hintText;
  final Widget? suffixIcon;
  const CommonTextForm(
      {super.key,
      required this.borderColor,
      required this.onChanged,
      required this.controller,
      required this.hintText,
      this.suffixIcon,
      this.obscureText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      cursorColor: Colors.black,
      obscureText: obscureText ?? false,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        suffixIcon: suffixIcon ?? const SizedBox.shrink(),
        enabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
        disabledBorder:
            OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
        focusedBorder:
            OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
        border: OutlineInputBorder(borderSide: BorderSide(color: borderColor)),
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.grey[400]),
      ),
      onChanged: onChanged,
    );
  }
}
