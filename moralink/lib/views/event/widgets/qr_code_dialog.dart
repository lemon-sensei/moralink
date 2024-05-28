// ---------- Common
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../models/qr_code.dart';

class QRCodeDialog extends StatelessWidget {
  final QRCode qrCode;

  const QRCodeDialog({
    super.key,
    required this.qrCode,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Your QR Code'),
      content: QrImageView(
        data: qrCode.code,
        version: QrVersions.auto,
        size: 200.0,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Close'),
        ),
      ],
    );
  }
}