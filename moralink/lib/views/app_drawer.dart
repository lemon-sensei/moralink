// ---------- Common
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

// ---------- Provider
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.authProvider,
  });

  final AuthProvider authProvider;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(
              color: Colors.blue,
            ),
            child: Text(
              'Welcome, ${authProvider.currentUser?.displayName ?? ''}',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          if (authProvider.currentUser == null)
            ListTile(
              leading: const Icon(Icons.login_rounded),
              title: const Text('Sign in'),
              onTap: () {
                context.go("/login");
              },
            ),
          if (authProvider.currentUser != null)
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                context.go("/profile");
              },
            ),
          if (authProvider.currentUser != null)
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Navigate to settings screen
              },
            ),
          const Divider(thickness: 1),
          ListTile(
            leading: const Icon(Icons.brightness_6),
            title: const Text('Dark Mode'),
            trailing: Switch(
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
                // Save the theme preference here
              },
            ),
          ),
          const Divider(thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(onPressed: () {}, child: const Text("Privacy Policy")),
              const Text(" • "),
              TextButton(
                  onPressed: () {}, child: const Text("Terms of Service")),
            ],
          )
        ],
      ),
    );
  }
}
