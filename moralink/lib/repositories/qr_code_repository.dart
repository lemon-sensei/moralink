// ---------- Common
import 'package:moralink/models/qr_code.dart';
import 'package:uuid/uuid.dart';

// ---------- Network
import 'package:cloud_firestore/cloud_firestore.dart';

class QRCodeRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Future<QRCode> generateQRCode(String eventId, String userId) async {
  //   final String code = const Uuid().v4(); // Generate a unique code using the uuid package
  //   final QRCode qrCode = QRCode(code: code, eventId: eventId, userId: userId);
  //
  //   await _firestore.collection('qrCodes').doc(code).set(qrCode.toJson());
  //
  //   return qrCode;
  // }

// Add other QR code-related methods as needed
}