import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rba/pages/home_page.dart';
import 'package:rba/pages/login_page.dart';
import 'package:rba/providers/user_provider.dart';
import 'firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
      debugShowCheckedModeBanner: false,
      title: 'RBA Events',
      initialRoute: '/',
      theme: ThemeData.from(
          colorScheme: ColorScheme.fromSeed(
        seedColor: Color.fromRGBO(8, 103, 136, 1),
        background: Color.fromRGBO(255, 241, 208, 1),
        secondary: Color.fromRGBO(240, 200, 8, 1),
        primary: Color.fromRGBO(8, 103, 136, 1),
        tertiary: Color.fromRGBO(6, 174, 213, 1),
        error: Color.fromRGBO(221, 28, 26, 1),
      )),
      routes: {
        '/login': (context) => const LoginPage(),
        '/main': (context) => const HomePage(),
      },
      home: const StartPage(),
    );
  }
}
