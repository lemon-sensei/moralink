// ---------- Common
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:universal_html/html.dart';
import 'package:js/js.dart';

class QRCodeScannerScreen extends StatefulWidget {
  const QRCodeScannerScreen({super.key});

  @override
  _QRCodeScannerScreenState createState() => _QRCodeScannerScreenState();
}

class _QRCodeScannerScreenState extends State<QRCodeScannerScreen> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  QRViewController? controller;

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('QR Code Scanner'),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 4,
            child: QRView(
              key: qrKey,
              onQRViewCreated: _onQRViewCreated,
              overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: 300,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                'Scan a QR code',
                style: TextStyle(fontSize: 20),
              ),
            ),
          )
        ],
      ),
    );
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.scannedDataStream.listen((scanData) {
      // Handle the detected QR code data
      print('QR code detected: ${scanData.code}');
    });
  }

  void _requestCameraPermission() async {
    final userAgent = window.navigator.userAgent.toLowerCase();

    if (userAgent.contains('chrome')) {
      await window.navigator.permissions?.request(
        PermissionDescriptor('camera'),
      );
    } else if (userAgent.contains('firefox')) {
      await window.navigator.mediaDevices?.getUserMedia({'video': true});
    } else if (userAgent.contains('safari')) {
      // Safari on iOS devices doesn't require explicit camera permissions
      // as it prompts the user when getUserMedia is called
    } else {
      // Handle other browsers or show an error message
    }
  }

  @override
  void initState() {
    super.initState();
    _requestCameraPermission();
  }
}

@JS()
external PermissionDescriptor(String name);
