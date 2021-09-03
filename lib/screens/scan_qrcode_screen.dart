// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class ScanQrCodeScreen extends StatefulWidget {
  const ScanQrCodeScreen({Key? key}) : super(key: key);

  @override
  _ScanQrCodeScreenState createState() => _ScanQrCodeScreenState();
}

class _ScanQrCodeScreenState extends State<ScanQrCodeScreen> {
  final qrViewKey = GlobalKey(debugLabel: 'QR');
  QRViewController? qrViewController;
  Barcode? barcode;

  @override
  void dispose() {
    qrViewController?.dispose();
    super.dispose();
  }

  @override
  void reassemble() async {
    super.reassemble();
    if (Platform.isAndroid) {
      await qrViewController!.pauseCamera();
    }
    qrViewController!.resumeCamera();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          buildQrView(context),
          Positioned(
            bottom: 10.0,
            child: buildResult(),
          ),
          Positioned(
            top: 10.0,
            child: buildControlButtons(),
          ),
        ],
      ),
    );
  }

  Widget buildControlButtons() => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          // mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            IconButton(
              onPressed: qrViewController?.toggleFlash,
              icon: FutureBuilder<bool?>(
                future: qrViewController?.getFlashStatus(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return Icon(
                      snapshot.data!
                          ? Icons.flash_on_rounded
                          : Icons.flash_off_rounded,
                    );
                  } else {
                    return Container();
                  }
                },
              ),
            ),
            IconButton(
              onPressed: qrViewController?.flipCamera,
              icon: FutureBuilder(
                future: qrViewController?.getCameraInfo(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) {
                    return const Icon(Icons.switch_camera_rounded);
                  } else {
                    return Container();
                  }
                },
              ),
            ),
          ],
        ),
      );

  Widget buildResult() => Container(
        padding: const EdgeInsets.all(12.0),
        decoration: BoxDecoration(
          color: Colors.white24,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Text(
          barcode != null ? 'Result: ${barcode!.code}' : 'Scan a code',
          maxLines: 3,
        ),
      );

  Widget buildQrView(BuildContext context) {
    return QRView(
      key: qrViewKey,
      onQRViewCreated: onQRViewCreated,
      overlay: QrScannerOverlayShape(
        borderWidth: 10.0,
        borderLength: 20.0,
        borderRadius: 10.0,
        borderColor: Theme.of(context).accentColor,
        cutOutSize: MediaQuery.of(context).size.width * 0.8,
      ),
    );
  }

  void onQRViewCreated(QRViewController qrViewController) {
    setState(() {
      this.qrViewController = qrViewController;
    });

    qrViewController.scannedDataStream.listen(
      (scannedCode) => setState(
        () => barcode = scannedCode,
      ),
    );
  }
}
