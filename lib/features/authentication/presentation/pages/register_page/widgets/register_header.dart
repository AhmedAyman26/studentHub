import 'package:flutter/material.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        width: double.infinity,
        child: Image(
          image: AssetImage('assets/images/signup.png'),
          fit: BoxFit.fill,
        ));
  }
}
