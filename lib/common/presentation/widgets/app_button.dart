import 'dart:io';
import 'package:flutter/material.dart';
class AppButton extends StatelessWidget {
  final double width;
  final Color background;
  final bool isUpperCase;
  final double radius;
  final Function function;
  final String text;
  const AppButton ({super.key, this.width=double.infinity, this.background=Colors.lightBlue, this.isUpperCase=true,  this.radius=3.0, required this.function, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
        color: background,
      ),
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );

  }
}
