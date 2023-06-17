import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rba/providers/user_provider.dart';
import 'package:rba/services/firebase_auth_helper.dart';
import 'package:rba/widgets/user_information.dart';

class MyHomePage extends ConsumerWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final String value = ref.watch(userProvider);
    ref.listen(userProvider, (String? previous, String value) {
      if (value == "default") {
        Navigator.pushNamed(context, '/login');
      }
    });
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(title),
            Text(
              value,
              style: const TextStyle(fontSize: 24),
            ),
            const UserInformation(),
          ],
        ),
      ),
      floatingActionButton: Wrap(
        direction: Axis.horizontal,
        children: [
          FloatingActionButton(
            onPressed: FirebaseAuthHelper.signInWithGoogle,
            tooltip: 'Log In',
            child: Icon(Icons.login),
          ),
          FloatingActionButton(
            onPressed: () =>
                ref.read(userProvider.notifier).state = 'some value',
            tooltip: 'Change Value',
            child: Icon(Icons.change_circle),
          ),
          FloatingActionButton(
            onPressed: FirebaseAuthHelper.signOut,
            tooltip: 'Log Out',
            child: Icon(Icons.logout),
          ),
        ],
      ),
    );
  }
}
