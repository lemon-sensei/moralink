import 'package:qr_flutter/qr_flutter.dart';
import 'package:flutter/material.dart';

class QRCodeService {
  static Widget generateQRCodeWidget(String data, double size) {
    return QrImageView(
      data: data,
      version: QrVersions.auto,
      size: size,
    );
  }
}