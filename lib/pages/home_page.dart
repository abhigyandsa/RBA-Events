import 'package:rba/pages/login_page.dart';
import 'package:rba/providers/qr_data_provider.dart';
import 'package:rba/providers/user_provider.dart';
import 'package:rba/services/firebase_auth_helper.dart';
import 'package:rba/services/user_information.dart';
import 'package:rba/widgets/cute_qrcode.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pretty_qr_code/pretty_qr_code.dart';
import 'package:rba/widgets/qr_scanner.dart';
import 'package:rba/widgets/textfield_withqr.dart';

class StartPage extends ConsumerWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(userProvider);
    return value == null ? const LoginPage() : const HomePage2();
  }
}

class HomePage2 extends ConsumerWidget {
  const HomePage2({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    return Scaffold(
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            user.toString(),
            style: const TextStyle(fontSize: 11),
          ),
          TextButton(
            onPressed: () async {
              UserInformation ui = const UserInformation(
                  email: "i21jains@iimidr.ac.in",
                  name: "Saumya J",
                  phone: "9833780180",
                  adminlevel: 9);
              UserInformation ui2 = const UserInformation(
                  email: "abhigyandsa@gmail.com",
                  name: "Abhigyan D",
                  phone: "9875340025",
                  adminlevel: 9);
              await ui.postUserInformation();
              await ui2.postUserInformation();
            },
            child: const Text('Post'),
          ),
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await FirebaseAuthHelper.signOut();
        },
      ),
    );
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
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.camera_alt),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Scaffold(
                        appBar: AppBar(
                          title: const Text('QR code Generator'),
                        ),
                        body: const TextFieldWithQR(),
                      ),
                    ),
                  );
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Icon(Icons.sailing_rounded),
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              ElevatedButton(
                onPressed: () async {
                  await FirebaseAuthHelper.signOut();
                },
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
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
                    : const SizedBox.shrink(),
                qrCode != 'default'
                    ? Column(
                        children: [
                          QRCode(text: qrCode?.email ?? 'default'),
                          Text(qrCode?.email ?? 'default'),
                        ],
                      )
                    : const SizedBox.shrink()
              ],
            );
          }),
        ], // children
      ),
    );
  }
}
