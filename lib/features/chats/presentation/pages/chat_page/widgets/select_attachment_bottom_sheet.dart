import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SelectAttachmentBottomSheet extends StatelessWidget {
  const SelectAttachmentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
      height: 278.h,
      width: 250.w,
      child: const Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AttachmentItem(
                      icon: Icons.insert_drive_file,
                      color: Colors.indigo,
                      text: 'Document'),
                  AttachmentItem(
                      icon: Icons.camera_alt,
                      color: Colors.pink,
                      text: 'Camera'),
                  AttachmentItem(
                      icon: Icons.photo, color: Colors.purple, text: 'Gallery'),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AttachmentItem(
                      icon: Icons.headset, color: Colors.orange, text: 'Audio'),
                  AttachmentItem(
                      icon: Icons.location_pin,
                      color: Colors.teal,
                      text: 'Location'),
                  AttachmentItem(
                      icon: Icons.person, color: Colors.blue, text: 'Contact'),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AttachmentItem extends StatelessWidget {
  final IconData icon;
  final Color color;
  final String text;

  const AttachmentItem(
      {super.key, required this.icon, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      child: Column(
        children: [
          CircleAvatar(
            radius: 30,
            backgroundColor: color,
            child: Icon(
              icon,
              size: 29,
              color: Colors.white,
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
            ),
          )
        ],
      ),
    );
  }
}
