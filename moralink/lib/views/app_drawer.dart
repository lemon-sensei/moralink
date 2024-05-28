// ---------- Common
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moralink/models/user_role.dart';
import 'package:moralink/providers/user_provider.dart';

// ---------- Provider
import 'package:provider/provider.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.authProvider,
    required this.userProvider,
  });

  final AuthProvider authProvider;
  final UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
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
          ListTile(
            leading: const Icon(Icons.search_rounded),
            title: const Text("Browse events"),
            onTap: () {
              context.go("/home");
            },
          ),
          if (authProvider.currentUser == null)
            ListTile(
              leading: const Icon(Icons.login_rounded),
              title: const Text('Sign in'),
              onTap: () {
                context.push("/login");
              },
            ),
          if (authProvider.currentUser != null)
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('Profile'),
              onTap: () {
                context.push("/profile");
              },
            ),
          if (authProvider.currentUser != null)
            ListTile(
              leading: const Icon(Icons.person),
              title: const Text('My Events'),
              onTap: () {
                context.push("/my-event");
              },
            ),
          if (authProvider.currentUser != null &&
              userProvider.currentUser?.role == UserRole.admin)
            const Divider(thickness: 1),
          if (authProvider.currentUser != null &&
              userProvider.currentUser?.role == UserRole.admin)
            const ListTile(
              title: Text('Admin Panel'),
            ),
          if (authProvider.currentUser != null &&
              userProvider.currentUser?.role == UserRole.admin)
            ListTile(
              leading: const Icon(Icons.create_rounded),
              title: const Text("Create New Event"),
              onTap: () {
                context.push("/admin/create-event");
              },
            ),
          if (authProvider.currentUser != null &&
              userProvider.currentUser?.role == UserRole.admin)
            ListTile(
              leading: const Icon(Icons.dashboard_rounded),
              title: const Text("Dashboard"),
              onTap: () {
                context.push("/admin/dashboard");
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
          if (authProvider.currentUser != null)
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Navigate to settings screen
              },
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
