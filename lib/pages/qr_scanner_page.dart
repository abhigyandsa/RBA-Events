import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rba/widgets/qr_overlay.dart';
import '../providers/qr_data_provider.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class Scanner extends ConsumerStatefulWidget {
  const Scanner({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ScannerState();
}

class _ScannerState extends ConsumerState<Scanner> {
  late final MobileScannerController _cameraController;

  @override
  void initState() {
    super.initState();
    _cameraController = MobileScannerController();
  }

  @override
  void dispose() {
    super.dispose();
    _cameraController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('QR Scanner'),
        actions: [
          IconButton(
            icon: ValueListenableBuilder(
              valueListenable: _cameraController.torchState,
              builder: (context, state, child) {
                switch (state) {
                  case TorchState.off:
                    return const Icon(Icons.flash_off, color: Colors.grey);
                  case TorchState.on:
                    return const Icon(Icons.flash_on, color: Colors.yellow);
                }
              },
            ),
            onPressed: () => _cameraController.toggleTorch(),
          ),
          IconButton(
            icon: ValueListenableBuilder(
              valueListenable: _cameraController.cameraFacingState,
              builder: (context, state, child) {
                switch (state) {
                  case CameraFacing.front:
                    return const Icon(Icons.camera_front);
                  case CameraFacing.back:
                    return const Icon(Icons.camera_rear);
                }
              },
            ),
            onPressed: () => _cameraController.switchCamera(),
          ),
        ],
      ),
      body: Stack(
        alignment: FractionalOffset.center,
        fit: StackFit.expand,
        children: [
          MobileScanner(
            controller: _cameraController,
            // fit: BoxFit.contain,
            onDetect: (capture) {
              final List<Barcode> barcodes = capture.barcodes;
              ref.read(qrdataProvider.notifier).state =
                  barcodes[barcodes.length - 1].rawValue;
              Navigator.popUntil(
                  context,
                  (Route<dynamic> route) =>
                      route.isFirst); //should only pop until scanner launched
            },
          ),
          QRScannerOverlay(overlayColour: Colors.black.withOpacity(0.5)),
        ],
      ),
    );
  }
}
