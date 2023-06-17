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
            const UserListScreen(),
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

class UserListScreen extends StatelessWidget {
  const UserListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance.collection('users').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const CircularProgressIndicator();
        }

        if (!snapshot.hasData) {
          return const CircularProgressIndicator();
        }

        final userList = snapshot.data?.docs ?? [];
        return ListView.builder(
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: userList.length,
          itemBuilder: (BuildContext context, int index) {
            final userData = userList[index].data() ?? {};
            final name = (userData as Map)['name'];
            return ListTile(
              title: Text(name ?? ''),
            );
          },
        );
      },
    );
  }
}