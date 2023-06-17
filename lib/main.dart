import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rba/pages/login_page.dart';
import 'package:rba/providers/user_provider.dart';
import 'firebase_options.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'pages/my_home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      print("trigger");
      if (user == null) {
        ref.read(userProvider.notifier).state = 'default';
      } else {
        ref.read(userProvider.notifier).state = user.email ?? 'default';
      }
    });

    return MaterialApp(
      title: 'RBA Events',
      initialRoute: '/',
      routes: {
        '/login': (context) => const LoginPage(),
        '/main': (context) => const MyHomePage(
              title: 'RBA Events',
            ),
      },
      home: const LoginPage(),
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
