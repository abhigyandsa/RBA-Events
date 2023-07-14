import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rba/services/firebase_auth_helper.dart';
import 'package:rba/widgets/devpanel.dart';
import 'package:rba/widgets/my_outline_button.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const ThemeDrawer(),
      body: Stack(
        children: [
          // Align(
          //   alignment: Alignment.topRight,
          //   child: Container(
          //     height: MediaQuery.of(context).size.height,
          //     decoration: const BoxDecoration(
          //       image: DecorationImage(
          //         image: AssetImage('assets/images/wavy_background.png'),
          //         fit: BoxFit.fill,
          //       ),
          //     ),
          //   ),
          // ),
          Positioned(
            top: 0,
            left: 0,
            child: Column(
              children: [
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text(
                      "Login",
                      style: Theme.of(context).textTheme.displayLarge?.copyWith(
                            color: Theme.of(context).colorScheme.primary,
                            fontWeight: FontWeight.w200,
                            fontSize: 104,
                          ),
                    ),
                  ),
                ),
                Divider(
                    color: Theme.of(context).colorScheme.primary,
                    thickness: 100),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Column(
              children: [
                const Spacer(),
                //need to add Sized boxes for this more buttons.
                Consumer(builder: (context, ref, child) {
                  return IntrinsicWidth(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        MyOutlineButton(
                            onPressed: () async {
                              await FirebaseAuthHelper.signInWithGoogle();
                            },
                            icon: const FaIcon(FontAwesomeIcons.google),
                            text: "Google"),
                        const SizedBox(height: 8),
                        MyOutlineButton(
                            onPressed: () async {
                              await FirebaseAuthHelper.signInWithGoogle();
                            },
                            icon: const FaIcon(FontAwesomeIcons.microsoft),
                            text: "Microsoft"),
                        const SizedBox(height: 8),
                        MyOutlineButton(
                            onPressed: () async {
                              await FirebaseAuthHelper.signInWithGoogle();
                            },
                            icon: const FaIcon(FontAwesomeIcons.facebook),
                            text: "Facebook"),
                      ],
                    ),
                  );
                }),
                const SizedBox(height: 164),
                Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Consumer(
                    builder: (context, ref, child) {
                      return TextButton(
                        onPressed: () => Scaffold.of(context).openDrawer(),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            FaIcon(
                              FontAwesomeIcons.water,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            const Text('Made with Bacon!'),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
