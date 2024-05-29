// ---------- Common
import 'package:flutter/material.dart';
import '../../models/user_role.dart';
import '../app_drawer.dart';

// ---------- Network
import 'package:go_router/go_router.dart';

// ---------- Provider
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/event_provider.dart';
import '../../providers/user_provider.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  State<AdminDashboard> createState() => _AdminDashboardState();
}

class _AdminDashboardState extends State<AdminDashboard> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final eventProvider = Provider.of<EventProvider>(context, listen: false);

    if (userProvider.currentUser?.role != UserRole.admin) {
      context.go('/home');
      return;
    }

    authProvider.currentUser;
    await eventProvider.fetchEvents();
    await userProvider.fetchCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final eventProvider = Provider.of<EventProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Admin Dashboard"),
        actions: [
          if (authProvider.currentUser != null)
            IconButton(
              icon: const Icon(Icons.qr_code_scanner_rounded),
              onPressed: () {
                context.push("/admin/qr-code-scanner");
              },
            ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                context.push("/admin/create-event");
              },
              child: const Text("Create New Event"),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to event management
              },
              child: const Text('Manage Events'),
            ),
            const SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // Navigate to user management
              },
              child: const Text('Manage Users'),
            ),
          ],
        ),
      ),
      drawer: AppDrawer(
        authProvider: authProvider,
        userProvider: userProvider,
      ),
    );
  }
}
