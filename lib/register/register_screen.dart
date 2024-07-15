import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late QRViewController _controller;
  final GlobalKey _qrKey = GlobalKey(debugLabel: 'QR');
  String loginCode = '';
  final password = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
    password.dispose();
  }

  void _onQRViewCreated(QRViewController controller) {
    setState(() {
      _controller = controller;
      _controller.scannedDataStream.listen((scanData) {
        print(' data: ${scanData.code}');
        // Handle the scanned data as desired
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.fromRGBO(72, 2, 151, 1),
                  Color.fromRGBO(51, 2, 108, 1),
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(32.0),
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Center(
                    child: Text(
                      "Register",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 37,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                  ),
                  Expanded(
                    flex: 1,
                    child: QRView(
                      key: _qrKey,
                      onQRViewCreated: _onQRViewCreated,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
