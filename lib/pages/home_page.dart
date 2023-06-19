import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:rba/pages/login_page.dart';
import 'package:rba/providers/theme_provider.dart';
import 'package:rba/providers/user_provider.dart';
import 'package:rba/services/user_information.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rba/widgets/mydrawer.dart';
import 'package:rba/pages/qr_scanner_page.dart';

class StartPage extends ConsumerWidget {
  const StartPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final value = ref.watch(userProvider);
    return value == null ? const LoginPage() : const HomePage();
  }
}

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userProvider);
    final admin = user?.adminlevel ?? 0;

    return Scaffold(
      drawer: const ThemeDrawer(),
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
      extendBodyBehindAppBar: true,
      endDrawer: const MyDrawer(),
      appBar: AppBar(
          elevation: 0,
          backgroundColor: Theme.of(context).colorScheme.background,
          actions: [
            admin > 9
                ? TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const Scanner(),
                        ),
                      );
                    },
                    child: const FaIcon(FontAwesomeIcons.cameraRetro),
                  )
                : const SizedBox.shrink(),
            Builder(
              builder: (context) => TextButton(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: FaIcon(
                    FontAwesomeIcons.userLarge,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                onPressed: () => Scaffold.of(context).openEndDrawer(),
              ),
            ),
          ]),
    );
  }
}

class ThemeDrawer extends StatelessWidget {
  const ThemeDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(
            height: 104,
            child: DrawerHeader(
                padding: const EdgeInsets.fromLTRB(16, 8, 0, 0),
                decoration:
                    BoxDecoration(color: Theme.of(context).colorScheme.primary),
                child: Text(
                  'Dev Panel',
                  style: Theme.of(context).textTheme.displayLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                        fontSize: 44,
                        fontWeight: FontWeight.w300,
                      ),
                )),
          ),
          Consumer(
            builder: (context, ref, child) {
              return ListTile(
                  title: const Text("Toggle"),
                  onTap: () {
                    ref.read(darkModeProvider.notifier).toggle();
                  });
            },
          ),
        ],
      ),
    );
  }
}
