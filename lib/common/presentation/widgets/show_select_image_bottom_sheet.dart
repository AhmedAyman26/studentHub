import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

var profileImagePicker = ImagePicker();
File? pickedImage;
String? profileImageLink;

showSelectImageBottomSheet(
    BuildContext context, void Function(File image)? pickedImageCallback) {
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
                    var picked = await ImagePicker()
                        .pickImage(source: ImageSource.camera);
                    if (picked != null) {
                      pickedImage = File(picked.path);
                      pickedImageCallback!(pickedImage!);
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
