// ---------- Common
import 'package:flutter/material.dart';

// ---------- Network
import 'package:go_router/go_router.dart';

// ---------- Provider
import 'package:provider/provider.dart';
import 'package:moralink/providers/user_provider.dart';
import '../../providers/auth_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.currentUser;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 32),
          Center(
            child: ElevatedButton(
              onPressed: () async {
                // Sign out logic
                await authProvider.signOut();
                // Navigate to the /home route after successful sign out
                if (!context.mounted) return;
                context.go('/home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red, // Change the primary color to red
              ),
              child: Text(
                'Sign Out',
                style: textTheme.labelLarge?.copyWith(color: Colors.white),
              ),
            ),
          ),
          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
