import 'package:cmsc23project/models/donor_form.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class QrCodePage extends StatefulWidget {
  DonorForm formData;

  QrCodePage({super.key, required this.formData});

  @override
  State<QrCodePage> createState() => _QrCodePageState();
}

class _QrCodePageState extends State<QrCodePage> {
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
                        child: QrImageView(data: 'haha'),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: Text("Reference Id: 63h4u12-182h4h4yh3", style: TextStyle(fontSize: 15),),
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
      onPressed: () {
        // save qr to device
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
