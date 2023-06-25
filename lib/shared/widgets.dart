import 'package:flutter/material.dart';

Widget defaultButton({
  double width = double.infinity,
  Color background = Colors.lightBlue,
  bool isUpperCase = true,
  double radius=3.0,
  required Function function,
  required String text,
}) =>
    Container(
      width: width,
      height: 40,
      child: MaterialButton(
        onPressed: () {
          function();
        },
        child: Text(
          isUpperCase ? text.toUpperCase() : text,
          style: TextStyle(color: Colors.white),
        ),
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(
          radius,
        ),
          color: background,
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

Widget defaultFormField({
  required TextEditingController controller,
  required TextInputType type,
  Function? onChange,
  Function()? onTap,
  required validate,
  required String label,
  required IconData prefix,
  IconData? suffix,
  Function? suffixPressed,
  bool isPassword = false,
  ValueChanged<String>? onSubmit,
}) =>TextFormField(
      onFieldSubmitted: onSubmit,
      obscureText: isPassword,
      controller: controller,
      keyboardType: type,
      onTap: onTap,
      validator: validate,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
          icon: Icon(
            suffix,
          ),
          onPressed: () {
            suffixPressed!();
          },
        )
            : null,
        border: OutlineInputBorder(),
      ),
    );

showLoading(context)
{
  return showDialog(
    context: context,
    builder: (context)=>AlertDialog(
      title: Text('please wait'),
      content: Container(
          height: 50,
          child: Center(child: CircularProgressIndicator(),)),
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



