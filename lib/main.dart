import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:rba/pages/home_page.dart';
import 'package:rba/pages/login_page.dart';
import 'package:rba/pages/qr_scanner_page.dart';
import 'package:rba/providers/user_provider.dart';
import 'package:rba/services/user_information.dart';
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
        ref.read(userProvider.notifier).setNull();
      } else {
        if (user.email == null) {
          ref.read(userProvider.notifier).setNull();
        } else {
          ref.read(userProvider.notifier).initUsrData(user.email!);
        }
      }
    });

    ref.listen<UserInformation?>(userProvider, (previous, value) {
      if (previous == null && value != null) {
        ref.read(userProvider.notifier).getUsrData();
      } else if (previous != null &&
          value != null &&
          previous.email != value.email) {
        ref.read(userProvider.notifier).getUsrData();
      }
    });

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'RBA Events',
      initialRoute: '/',
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromRGBO(8, 103, 136, 1),
          // background: const Color.fromRGBO(255, 241, 208, 1),
          secondary: const Color.fromRGBO(240, 200, 8, 1),
          primary: const Color.fromRGBO(8, 103, 136, 1),
          tertiary: const Color.fromRGBO(6, 174, 213, 1),
          error: const Color.fromRGBO(221, 28, 26, 1),
        ),
        useMaterial3: true,
      ),
      darkTheme: ThemeData.dark(useMaterial3: true),
      themeMode: ThemeMode.dark,
      routes: {
        '/login': (context) => const LoginPage(),
        '/main': (context) => const StartPage(),
        '/scanner': (context) => const Scanner(),
        // '/scanned_data': (context) => const StartPage(),
      },
      home: const StartPage(),
    );
  }
}
