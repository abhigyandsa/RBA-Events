import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class QRCode extends StatelessWidget {
  const QRCode({
    super.key,
    required this.text,
  });

  final String text;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: PrettyQr(
            image: AssetImage('assets/2ndiris.png'),
            // typeNumber: 3,
            size: 256,
            data: text,
            errorCorrectLevel: QrErrorCorrectLevel.H,
            roundEdges: true,
          )),
    );
  }
}
