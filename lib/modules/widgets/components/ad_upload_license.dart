import 'dart:io';

import 'package:flutter/material.dart';

class ADUploadLicense extends StatelessWidget {
  final String text;
  final String? displayImage;

  const ADUploadLicense({
    Key? key,
    required this.displayImage,
    required this.text,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      margin: const EdgeInsets.symmetric(vertical: 15),
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
      decoration: BoxDecoration(
          color: Colors.white12,
          borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50.0),
              topRight: Radius.circular(50.0))),
      child: displayImage != ""
          ? SizedBox(
        width: double.infinity,
              child: Image.file(
                File(displayImage!),
                fit: BoxFit.fill,
              ),
            )
          : Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(
                  Icons.camera_enhance,
                  color: Colors.white,
                ),
                Text(
                  text,
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                ),
                Icon(Icons.add, color: Colors.white, size: 28),
              ],
            ),
    );
  }
}
