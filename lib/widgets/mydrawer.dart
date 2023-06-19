import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:lottie/lottie.dart';
import 'package:rba/providers/user_provider.dart';
import 'package:rba/services/firebase_auth_helper.dart';
import 'package:rba/widgets/qr_scanner.dart';

import 'cute_qrcode.dart';

class MyDrawer extends ConsumerWidget {
  const MyDrawer({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    const double circleRadius = 100.0;
    const double circleBorderWidth = 8.0;

    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 104,
            child: DrawerHeader(
                padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                decoration:
                    BoxDecoration(color: Theme.of(context).colorScheme.primary),
                child: Text(
                  'Profile',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 44,
                        fontWeight: FontWeight.w300,
                      ),
                )),
          ),
          user != null
              ? Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Stack(alignment: Alignment.topCenter, children: [
                    Padding(
                      padding: const EdgeInsets.only(top: circleRadius / 2.0),
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
                                  Text(
                                    user.phone ?? '+91 7872537510',
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyLarge
                                        ?.copyWith(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                  ),
                                  Text(user.email,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.copyWith(
                                            color:
                                                Theme.of(context).primaryColor,
                                          )),
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
                          padding: const EdgeInsets.all(circleBorderWidth),
                          child:
                              Lottie.asset('assets/lottie/female-avatar.json')),
                    ),
                  ]),
                )
              : const Text('No User Logged In'),
          // const Spacer(),
          const SizedBox(height: 274),
          FilledButton(
            onPressed: () async {
              await FirebaseAuthHelper.signOut();
            },
            style: FilledButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(0),
              ),
              padding: EdgeInsets.zero,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                Text("Logout "),
                FaIcon(FontAwesomeIcons.arrowRightFromBracket),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
