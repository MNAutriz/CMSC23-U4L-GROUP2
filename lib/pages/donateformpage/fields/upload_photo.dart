import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhotoButtons extends StatefulWidget {
  const UploadPhotoButtons({super.key});

  @override
  State<UploadPhotoButtons> createState() => _UploadPhotoButtonsState();
}

class _UploadPhotoButtonsState extends State<UploadPhotoButtons> {
  File? _selectedImage;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Card(
                  child: IconButton(
                    icon: const Icon(Icons.attach_file, color: Color(0xFF3D8361)),
                    onPressed: () {
                      pickImageFromGallery();
                    },
                  ),
                ),
              ),
            ),
            Expanded(
              child: Card(
                child: IconButton(
                  icon: const Icon(Icons.camera_alt, color: Color(0xFF3D8361)),
                  onPressed: () {
                    pickImageFromCamera();
                  },
                ),
              ),
            ),
          ],
        ),
        _selectedImage != null
            ? Column(
                children: [
                  Image.file(_selectedImage!),
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        _selectedImage = null;
                      });
                    },
                  ),
                ],
              )
            : Container(),
      ],
    );
  }

  Future pickImageFromGallery() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return;

    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }

  Future pickImageFromCamera() async {
    final returnedImage = await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage == null) return;

    setState(() {
      _selectedImage = File(returnedImage.path);
    });
  }
}
