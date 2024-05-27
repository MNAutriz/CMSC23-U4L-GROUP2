import 'package:cmsc23project/models/donor_form.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

class SubmittedPage extends StatefulWidget {
  
  DonorForm formData;

  SubmittedPage({super.key, required this.formData});

  @override
  State<SubmittedPage> createState() => _SubmittedPageState();
}

class _SubmittedPageState extends State<SubmittedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Text("QR CODE PAGE")
      ),
      body: Column(
        children: [
          QrImageView(data: "test"),
        ]
      )
    );
  }
}