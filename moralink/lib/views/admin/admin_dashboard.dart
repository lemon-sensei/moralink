// ---------- Common
import 'package:flutter/material.dart';
import '../../models/user_role.dart';
import '../../shared/widgets/responsive_layout.dart';
import '../widget/app_drawer.dart';

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
  final TextEditingController _eventIdController = TextEditingController();

  @override
  void dispose() {
    _eventIdController.dispose();
    super.dispose();
  }

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

    await eventProvider.fetchEvents();
    await userProvider.fetchCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final eventProvider = Provider.of<EventProvider>(context);
    final textTheme = Theme.of(context).textTheme;

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
      body: ResponsiveLayout(
        mobileBody: _buildMobileBody(authProvider, userProvider, textTheme),
        tabletBody: _buildTabletBody(authProvider, userProvider, textTheme),
        desktopBody: _buildDesktopBody(authProvider, userProvider, textTheme),
      ),
      drawer: AppDrawer(
        authProvider: authProvider,
        userProvider: userProvider,
      ),
    );
  }

  Widget _buildMobileBody(
    AuthProvider authProvider,
    UserProvider userProvider,
    TextTheme textTheme,
  ) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 16.0),
            Center(
              child: Text(
                'Monitor Section',
                style: textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 32.0),
            Center(child: _buildMonitorCards(textTheme)),
            const SizedBox(height: 64.0),
            Center(
              child: Text(
                'Management Section',
                style: textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 32.0),
            Center(
                child: _buildManagementSection(
                    authProvider, userProvider, textTheme)),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletBody(
    AuthProvider authProvider,
    UserProvider userProvider,
    TextTheme textTheme,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Monitor',
                  style: textTheme.headlineSmall,
                ),
                const SizedBox(height: 16.0),
                _buildMonitorCards(textTheme),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Management',
                  style: textTheme.headlineSmall,
                ),
                const SizedBox(height: 16.0),
                _buildManagementSection(authProvider, userProvider, textTheme),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildDesktopBody(
    AuthProvider authProvider,
    UserProvider userProvider,
    TextTheme textTheme,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Monitor',
                  style: textTheme.headlineSmall,
                ),
                const SizedBox(height: 16.0),
                _buildMonitorCards(textTheme),
              ],
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Management',
                  style: textTheme.headlineSmall,
                ),
                const SizedBox(height: 16.0),
                _buildManagementSection(authProvider, userProvider, textTheme),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildMonitorCards(TextTheme textTheme) {
    return Column(
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Events',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 8.0),
                Text(
                  '-',
                  style: textTheme.headlineSmall,
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 16.0),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Users',
                  style: textTheme.titleMedium,
                ),
                const SizedBox(height: 8.0),
                Text(
                  '-',
                  style: textTheme.headlineSmall,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildManagementSection(
    AuthProvider authProvider,
    UserProvider userProvider,
    TextTheme textTheme,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Events',
          style: textTheme.titleMedium,
        ),
        const SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: () {
            context.push("/admin/create-event");
          },
          child: Text(
            "Create New Event",
            style: textTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: 16.0),
        TextField(
          controller: _eventIdController,
          decoration: InputDecoration(
            labelText: 'Event ID',
            hintText: 'Enter event ID to edit',
            border: OutlineInputBorder(),
          ),
        ),
        const SizedBox(height: 8.0),
        ElevatedButton(
          onPressed: () {
            final eventId = _eventIdController.text.trim();
            if (eventId.isNotEmpty) {
              context.push("/admin/edit-event/$eventId");
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Please enter an event ID')),
              );
            }
          },
          child: Text(
            'Edit Event',
            style: textTheme.bodyMedium,
          ),
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            // Navigate to event list management
            context.push("/admin/events");
          },
          child: Text(
            'Manage Events',
            style: textTheme.bodyMedium,
          ),
        ),
        Text(
          'Users',
          style: textTheme.titleMedium,
        ),
        const SizedBox(height: 16.0),
        ElevatedButton(
          onPressed: () {
            // Navigate to user management
          },
          child: Text(
            'Manage Users',
            style: textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
