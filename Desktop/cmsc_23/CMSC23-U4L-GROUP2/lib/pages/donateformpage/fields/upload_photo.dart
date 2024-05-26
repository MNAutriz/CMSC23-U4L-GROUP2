import 'package:flutter/material.dart';

class UploadPhotoButtons extends StatelessWidget {
  const UploadPhotoButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              child: IconButton(
                icon: const Icon(Icons.attach_file, color: Color(0xFF3D8361)),
                onPressed: () {},
              )
            )
            ),
          ),
        Expanded(
          child: Card(
            child: IconButton(
              icon: const Icon(Icons.camera_alt, color: Color(0xFF3D8361),),
              onPressed: () {}
            )
          )
        ),
      ],
    );
  }
}