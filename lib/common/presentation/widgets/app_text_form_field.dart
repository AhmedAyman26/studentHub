import 'package:flutter/material.dart';

class AppTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputType? type;
  final VoidCallback? onChange;
  final Function()? onTap;
  final String? Function(String?)? validate;
  final String? label;
  final Widget? prefix;
  final Widget? suffix;
  final Function? suffixPressed;
  final bool obscureText;
  final ValueChanged<String>? onSubmit;
  final String? hintText;

  const AppTextFormField(
      {super.key,
        required this.controller,
        this.type,
        this.onChange,
        this.onTap,
        this.validate,
        this.label,
        this.prefix,
        this.suffix,
        this.suffixPressed,
        this.onSubmit,
        this.obscureText = false, this.hintText});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onFieldSubmitted: onSubmit,
      obscureText: obscureText,
      controller: controller,
      keyboardType: type,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        hintText: hintText,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(width: 3, color: Colors.black12),
        ),
        labelText: label,
        prefixIcon: prefix,
        suffixIcon: suffix,
        border: const UnderlineInputBorder(),
      ),
    );
  }
}
