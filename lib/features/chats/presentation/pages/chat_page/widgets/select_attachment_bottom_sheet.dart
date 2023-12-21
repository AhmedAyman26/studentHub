import 'package:flutter/material.dart';

class SelectAttachmentBottomSheet extends StatelessWidget {
  const SelectAttachmentBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 278,
      width: 250,
      child: const Card(
        margin: EdgeInsets.all(18),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AttachmentItem(
                      icon: Icons.insert_drive_file,
                      color: Colors.indigo,
                      text: 'Document'),
                  SizedBox(
                    width: 40,
                  ),
                  AttachmentItem(
                      icon: Icons.camera_alt,
                      color: Colors.pink,
                      text: 'Camera'),
                  SizedBox(
                    width: 40,
                  ),
                  AttachmentItem(
                      icon: Icons.photo, color: Colors.purple, text: 'Gallery'),
                  SizedBox(
                    width: 40,
                  ),
                ],
              ),
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AttachmentItem(
                      icon: Icons.headset, color: Colors.orange, text: 'Audio'),
                  SizedBox(
                    width: 40,
                  ),
                  AttachmentItem(
                      icon: Icons.location_pin,
                      color: Colors.teal,
                      text: 'Location'),
                  SizedBox(
                    width: 40,
                  ),
                  AttachmentItem(
                      icon: Icons.person, color: Colors.blue, text: 'Contact'),
                  SizedBox(
                    width: 40,
                  ),
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
