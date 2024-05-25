import 'package:flutter/material.dart';
import 'package:moralink/services/qr_code_service.dart';

class QRCodeViewer extends StatelessWidget {
  final String data;

  const QRCodeViewer({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: QRCodeService.generateQRCodeWidget(data, 200),
    );
  }
}
