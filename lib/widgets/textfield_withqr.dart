import 'package:flutter/material.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';

class TextFieldPage extends StatelessWidget {
  const TextFieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Generator'),
      ),
      body: const TextFieldWithQR(),
    );
  }
}

class TextFieldWithQR extends StatefulWidget {
  const TextFieldWithQR({super.key});

  @override
  State<TextFieldWithQR> createState() => _TextFieldWithQRState();
}

class _TextFieldWithQRState extends State<TextFieldWithQR> {
  late TextEditingController controller;
  late Widget qrWidget;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void _makeQR() {
    setState(() {
      qrWidget = Card(
        color: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: controller.text.length < 25
              ? PrettyQr(
                  image: const AssetImage('assets/2ndiris.png'),
                  typeNumber: 3,
                  size: 256,
                  data: controller.text,
                  errorCorrectLevel: QrErrorCorrectLevel.H,
                  roundEdges: true,
                )
              : Text(
                  'Too Long',
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge
                      ?.copyWith(color: Colors.black),
                ),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextField(
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Enter a thing',
              ),
              controller: controller,
              onChanged: (_) => _makeQR(),
            ),
          ),
          ElevatedButton(
              onPressed: _makeQR,
              child: const Padding(
                padding: EdgeInsets.all(20.0),
                child: Icon(Icons.sailing_outlined),
              )),
          const SizedBox(height: 50),
          controller.text.isEmpty ? const SizedBox.shrink() : qrWidget
        ],
      ),
    );
  }
}
