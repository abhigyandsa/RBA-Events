import 'package:rba/pages/login_page.dart';
import 'package:rba/providers/qr_data_provider.dart';
import 'package:rba/providers/user_provider.dart';
import 'package:rba/services/firebase_auth_helper.dart';
import 'package:rba/widgets/cute_qrcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:rba/widgets/qr_scanner.dart';
import 'package:rba/widgets/textfield_withqr.dart';
import 'package:rba/widgets/user_information.dart';

class StartPage extends ConsumerWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(userProvider);
    return value == 'default' ? LoginPage() : HomePage();
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Scanner(),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.camera_alt),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: Text('QR code Generator'),
                        ),
                        body: TextFieldWithQR(),
                      ),
                    ),
                  );
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.sailing_rounded),
                ),
              ),
              SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuthHelper.signOut();
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(Icons.logout_outlined),
                ),
              ),
            ],
          ),
          Consumer(builder: (_, WidgetRef ref, __) {
            final value = ref.watch(qrdataProvider);
            final qrCode = ref.watch(userProvider);
            return Column(
              children: [
                value != null
                    ? Column(
                        children: [
                          Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)),
                            child: Padding(
                              padding: const EdgeInsets.all(20.0),
                              child: PrettyQr(
                                // typeNumber: 3,
                                size: 256,
                                data: value,
                                roundEdges: true,
                              ),
                            ),
                          ),
                          Text(value),
                        ],
                      )
                    : SizedBox.shrink(),
                qrCode != 'default'
                    ? Column(
                        children: [
                          QRCode(text: qrCode),
                          Text(qrCode),
                        ],
                      )
                    : SizedBox.shrink()
              ],
            );
          }),
        ], // children
      ),
    );
  }
}
