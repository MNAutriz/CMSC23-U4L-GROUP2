import 'package:cmsc23project/pages/donationdrivepage/qr_scanner/scanner_overlay.dart';
import 'package:cmsc23project/providers/donor_form_provider.dart';
import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';
import 'package:provider/provider.dart';

class QrScannerPage extends StatefulWidget {
  const QrScannerPage({super.key});

  @override
  State<QrScannerPage> createState() => _QrScannerPageState();
}

class _QrScannerPageState extends State<QrScannerPage> {
  String documentId = "";

  MobileScannerController cameraController = MobileScannerController(
    detectionSpeed: DetectionSpeed.noDuplicates,
    returnImage: true,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: SafeArea(
        child: Stack(
          children: [
            MobileScanner(
              controller: cameraController,
              onDetect: (capture) async {
                final List<Barcode> barcodes = capture.barcodes;
                for (final barcode in barcodes) {
                  documentId = barcode.rawValue ?? "";
                  print("Barcode found! $documentId");

                  if (documentId.isNotEmpty) {
                    try {
                      final formData = await context.read<DonorFormProvider>().getFormById(documentId);

                      if (formData != null) {
                        if (formData['forPickup'] == true) {
                          Navigator.pop(context);
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Pickup is not possible for this donation.'),
                            ),
                          );
                        } else {
                          await context.read<DonorFormProvider>().updateDonationFormStatus(documentId).then((val) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('Donation status updated successfully.'),
                              ),
                            );
                          });
                        }
                      } else {
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('Form not found.'),
                          ),
                        );
                      }
                    } catch (e) {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Error: $e'),
                        ),
                      );
                    }
                  } else {
                    Navigator.pop(context);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Invalid QR code.'),
                      ),
                    );
                  }
                }
              },
            ),
            QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
          ],
        ),
      ),
    );
  }
}
