import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.lightBlue,
  bool isUpperCase = true,
  double radius = 3.0,
  required Function function,
  required String text,
}) =>
    Container(
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

Widget defaultTextButton({
  required function,
  required String text,
}) =>
    TextButton(
      onPressed: function,
      child: Text(text.toUpperCase()),
    );

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
var profileImagePicker = ImagePicker();
File? pickedImage;
String? profileImageLink;

showSelectImageBottomSheet(BuildContext context,void Function(File image)? pickedImageCallback)
{
  showModalBottomSheet(
      context: context,
      builder: (context) => Container(
    padding: const EdgeInsets.all(20),
    child: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Please Choose Image',
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        InkWell(
          onTap: () async {
            var picked = await profileImagePicker.pickImage(
                source: ImageSource.gallery);
            if (picked != null) {
              pickedImage = File(picked.path);
              pickedImageCallback!(pickedImage!);
              // await FirebaseStorage.instance
              //     .ref()
              //     .child(
              //     'users/${Uri.file(pickedImage!.path).pathSegments.last}')
              //     .putFile(pickedImage!)
              //     .then((value) {
              //   value.ref.getDownloadURL().then((value) {
              //     profileImageLink = value;
              //   });
              // });
              // Navigator.of(context).pop();
            }
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: const Row(
              children: [
                Icon(
                  Icons.photo_outlined,
                  size: 30,
                ),
                SizedBox(
                  width: 20,
                ),
                Text(
                  'From Gallery',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
        InkWell(
          onTap: () async {
            var picked =
            await ImagePicker().pickImage(source: ImageSource.camera);
            if (picked != null) {
              pickedImage = File(picked.path);
              pickedImageCallback!(pickedImage!);
              // await FirebaseStorage.instance
              //     .ref()
              //     .child(
              //     'users/${Uri.file(pickedImage!.path).pathSegments.last}')
              //     .putFile(pickedImage!)
              //     .then((value) {
              //   value.ref.getDownloadURL().then((value) {
              //     profileImageLink = value;
              //   });
              // });
              // Navigator.of(context).pop();
            }
          },
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            child: const Row(
              children: [
                Icon(
                  Icons.camera_alt_outlined,
                  size: 30,
                ),
                SizedBox(width: 20),
                Text(
                  'From Camera',
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
          ),
        ),
      ],
    ),
  ));
}
showLoading(context) {
  return showDialog(
    context: context,
    builder: (context) => const AlertDialog(
      title: Text('please wait'),
      content: SizedBox(
          height: 50,
          child: Center(
            child: CircularProgressIndicator(),
          )),
    ),
  );
}

Widget myDivider() => Padding(
      padding: const EdgeInsetsDirectional.only(start: 20, end: 20),
      child: Container(
        width: double.infinity,
        height: 1.0,
        color: Colors.grey,
      ),
    );
