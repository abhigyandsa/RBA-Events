import 'package:flutter/material.dart';
import 'package:rba/my_home_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Align(
            alignment: Alignment.center,
            child: SafeArea(child: Text('e')),
          ),
          Positioned(
            top: 0,
            left: 0,
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Text(
                  "Login",
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Colors.black,
                        fontWeight: FontWeight.w200,
                      ),
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 16.0,
            right: 16.0,
            child: Column(
              children: [
                InkWell(
                  onTap: () async {
                    await const MyHomePage(title: 'a').signInWithGoogle();
                    Navigator.of(context).popAndPushNamed('/home');
                  },
                  child: Ink(
                    color: const Color(0xFF397AF3),
                    child: const Padding(
                      padding: EdgeInsets.all(6),
                      child: Wrap(
                        crossAxisAlignment: WrapCrossAlignment.center,
                        children: [
                          Icon(Icons.android),
                          SizedBox(width: 12),
                          Text('Sign in with Google'),
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
