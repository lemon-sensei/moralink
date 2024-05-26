// ---------- Common
import 'package:flutter/material.dart';
import 'package:moralink/views/event/event_list.dart';
import 'app_drawer.dart';

// ---------- Provider
import 'package:provider/provider.dart';
import 'package:moralink/providers/auth_provider.dart';
import 'package:moralink/providers/event_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final eventProvider = Provider.of<EventProvider>(context, listen: false);

    authProvider.currentUser;
    await eventProvider.fetchEvents();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final eventProvider = Provider.of<EventProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Moralink')),
        actions: [
          IconButton(
            icon: const Icon(Icons.qr_code_scanner_rounded),
            onPressed: () {},
          ),
        ],
      ),
      body: eventProvider.events.isEmpty
          ? const Center(child: Text('No events found'))
          : const EventListScreen(),
      drawer: AppDrawer(authProvider: authProvider),
    );
  }
}