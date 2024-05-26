import 'dart:convert';
import 'dart:io';
import 'package:cmsc23project/pages/donateformpage/fields/upload_photo/image_constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';

class UploadPhotoButtons extends StatefulWidget {
  const UploadPhotoButtons({super.key});

  @override
  State<UploadPhotoButtons> createState() => _UploadPhotoButtonsState();
}

class _UploadPhotoButtonsState extends State<UploadPhotoButtons> {
  File? _selectedImage;
  String? base64Image;

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
                    icon:
                        const Icon(Icons.attach_file, color: Color(0xFF3D8361)),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Card(
                        child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ClipRRect(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(8)),
                          child: Image.file(_selectedImage!)
                          // child: Image.memory(base64Decode(base64Image!))
                          ),
                    )),
                  ),
                  // Image.memory(base64Decode(base64Image!)),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: SizedBox(
                      width: double.infinity,
                      child: Card(
                        child: IconButton(
                          icon: const Icon(Icons.delete,
                              color: Color(0xFF3D8361)),
                          onPressed: () {
                            setState(() {
                              _selectedImage = null;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              )
            : const SizedBox(),
      ],
    );
  }

  Future pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (returnedImage == null) return; 

    setState(() {
      _selectedImage = File(returnedImage.path);
      debugPrint(_selectedImage.toString());
      base64Image = ImageConstants().convertToBase64(_selectedImage!);
      debugPrint(base64Image);
    });
  }

  Future pickImageFromCamera() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.camera);

    if (returnedImage == null) return;

    setState(() {
      _selectedImage = File(returnedImage.path);
      debugPrint(_selectedImage.toString());
      base64Image = ImageConstants().convertToBase64(_selectedImage!);
      debugPrint(base64Image);
    });
  }
}
