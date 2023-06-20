import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:rba/providers/theme_provider.dart';

class ThemeDrawer extends ConsumerWidget {
  const ThemeDrawer({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Drawer(
      child: ListView(
        // crossAxisAlignment: CrossAxisAlignment.stretch,
        padding: EdgeInsets.zero,
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
          ListTile(
            title: const Text("Toggle Theme"),
            onTap: () {
              ref.read(darkModeProvider.notifier).toggle();
            },
          ),
          ListTile(
            title: const Text("HomePage"),
            onTap: () {
              Navigator.of(context).pushNamed('/main');
            },
          ),
          ListTile(
            title: const Text("Scanner"),
            onTap: () {
              Navigator.of(context).pushNamed('/scanner');
            },
          ),
        ],
      ),
    );
  }
}
