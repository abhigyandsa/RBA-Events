import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';
import 'package:rba/providers/user_provider.dart';
import 'package:rba/services/firebase_auth_helper.dart';
import 'package:rba/widgets/qr_scanner.dart';
import 'package:rba/widgets/textfield_withqr.dart';

import 'cute_qrcode.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final double circleRadius = 100.0;
    final double circleBorderWidth = 8.0;

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            user != null
                ? Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Stack(alignment: Alignment.topCenter, children: [
                      Padding(
                        padding: EdgeInsets.only(top: circleRadius / 2.0),
                        child: Card(
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                              color: Theme.of(context).primaryColor,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(32),
                          ),
                          color: Theme.of(context).colorScheme.background,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 56.0),
                            child: Column(
                              children: [
                                Column(
                                  children: [
                                    Text(
                                      user.name ?? 'N/A',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall
                                          ?.copyWith(
                                              color: Theme.of(context)
                                                  .colorScheme
                                                  .primary,
                                              fontWeight: FontWeight.bold),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(user.phone ?? '+91 7872537510',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                    Text(user.email,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge),
                                    SizedBox(
                                      height: 256 + 8,
                                      child: QRCode(text: user.email),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        width: circleRadius,
                        height: circleRadius,
                        child: Padding(
                            padding: EdgeInsets.all(circleBorderWidth),
                            child: Lottie.asset(
                                'assets/lottie/female-avatar.json')),
                      ),
                    ]),
                  )
                : const Text('No User Logged In'),
            const SizedBox(
              height: 24,
            ),
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
          ],
        ),
      ),
    );
  }
}
