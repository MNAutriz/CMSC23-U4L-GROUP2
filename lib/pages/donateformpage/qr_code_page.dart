import 'dart:typed_data';
import 'package:cmsc23project/models/donor_form.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:screenshot/screenshot.dart';

class QrCodePage extends StatelessWidget {
  String documentId;

  QrCodePage({super.key, required this.documentId});

  final ScreenshotController screenshotController = ScreenshotController();
  Future<void> captureAndSaveImage() async {
    final Uint8List? uint8list = await screenshotController.capture();

    if (uint8list != null) {
      final PermissionStatus status = await Permission.storage.request();

      if (status.isGranted) {
        final result = await ImageGallerySaver.saveImage(uint8list);
        if (result['isSuccess']) {
          debugPrint("Successfully saved image");
        } else {
          debugPrint("Failed to save image: ${result['error']}");
        }
      } else {
        debugPrint("Permission to access storage denied.");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            backgroundColor: const Color(0xFF093731),
            iconTheme: const IconThemeData(color: Color(0xFFEEF2E6)),
            title: const Text("Donation Form Submitted!",
                style: TextStyle(
                    color: Color(0xFFEEF2E6), fontWeight: FontWeight.bold))),
        backgroundColor: const Color(0xFFEEF2E6),
        body: Column(children: [
          // put donation form id here
          Padding(
            padding: const EdgeInsets.all(32.0),
            child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  color: Colors.green[100],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Screenshot(
                            controller: screenshotController,
                            child: QrImageView(data: documentId)),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text(
                          "Reference Id: $documentId",
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(bottom: 16.0),
                        child: Text(
                          "Let our representative scan this at the drop-off point to update your donation status",
                          style: TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                )),
          ),
          _saveQrButton()
        ]));
  }

  Widget _saveQrButton() {
    return ElevatedButton(
      onPressed: () async {
        // save qr to device
        await captureAndSaveImage();
        
      },
      style: ElevatedButton.styleFrom(
        foregroundColor: const Color(0xFFEEF2E6),
        backgroundColor: const Color(0xFF093731), // text color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // rounded corners
        ),
        padding:
            const EdgeInsets.symmetric(vertical: 16, horizontal: 32), // padding
      ),
      child: const Text(
        "Save to Device",
        style: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
