// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:qr_scanner/screens/scan_qrcode_screen.dart';

class CreateQrCodeScreen extends StatefulWidget {
  const CreateQrCodeScreen({Key? key}) : super(key: key);

  @override
  _CreateQrCodeScreenState createState() => _CreateQrCodeScreenState();
}

class _CreateQrCodeScreenState extends State<CreateQrCodeScreen> {
  final TextEditingController qrController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blueGrey.shade400,
      appBar: AppBar(
        title: Text('QR Code Generator'),
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              QrImage(
                data: qrController.text,
                size: 200.0,
                backgroundColor: Colors.white,
              ),
              SizedBox(height: 20.0),
              buildTextField(),
              SizedBox(
                height: 150,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CreateQrCodeScreen(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.qr_code_scanner,
                      size: 30.0,
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ScanQrCodeScreen(),
                        ),
                      );
                    },
                    icon: Icon(
                      Icons.qr_code,
                      size: 30.0,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField() {
    return TextField(
      controller: qrController,
      style: const TextStyle(
        color: Colors.white,
        fontWeight: FontWeight.bold,
        fontSize: 20.0,
      ),
      decoration: InputDecoration(
        hintText: 'Enter the data',
        hintStyle: TextStyle(color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Theme.of(context).accentColor,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.0),
          borderSide: BorderSide(
            color: Theme.of(context).accentColor,
          ),
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.done, size: 30.0),
          color: Theme.of(context).accentColor,
          onPressed: () => setState(() {}),
        ),
      ),
    );
  }
}
