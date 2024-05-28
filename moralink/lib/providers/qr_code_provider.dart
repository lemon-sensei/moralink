import 'package:flutter/material.dart';
import 'package:moralink/models/qr_code.dart';
import 'package:moralink/repositories/qr_code_repository.dart';
import 'package:uuid/uuid.dart';

class QRCodeProvider extends ChangeNotifier {
  final QRCodeRepository _qrCodeRepository = QRCodeRepository();

  // Future<QRCode> generateQRCode(String eventId, String userId) async {
  //   final qrCode = await _qrCodeRepository.generateQRCode(eventId, userId);
  //   notifyListeners();
  //   return qrCode;
  // }

  QRCode generateTemporaryQRCode(String eventId, String userId) {
    final code = const Uuid().v4();
    return QRCode(code: code, eventId: eventId, userId: userId);
  }
}