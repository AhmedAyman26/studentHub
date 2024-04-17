import 'package:flutter/material.dart';
import 'package:graduation/common/utils/constants/image_paths.dart';

class RegisterHeader extends StatelessWidget {
  const RegisterHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
        width: double.infinity,
        child: Image(
          image: AssetImage(ImagesPaths.registerHeader),
          fit: BoxFit.fill,
        ));
  }
}
