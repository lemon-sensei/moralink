// ---------- Common
import 'package:flutter/material.dart';
import 'package:moralink/providers/theme_provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:universal_html/html.dart';
import '../../models/event.dart';

// ---------- Network
import 'package:go_router/go_router.dart';

// ---------- Provider
import 'package:provider/provider.dart';
import 'package:moralink/providers/user_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/event_provider.dart';
import '../../providers/qr_code_provider.dart';

class MyEventScreen extends StatefulWidget {
  const MyEventScreen({super.key});

  @override
  State<MyEventScreen> createState() => _MyEventScreenState();
}

class _MyEventScreenState extends State<MyEventScreen> {
  late String hostDomain = "";

  @override
  void initState() {
    super.initState();
    _fetchHostDomainName();
    _fetchData();
  }

  Future<void> _fetchHostDomainName() async {
    String currentURL = window.location.href;
    final uri = Uri.parse(currentURL);
    final baseUrl = '${uri.scheme}://${uri.host}';
    hostDomain = baseUrl;
  }

  Future<void> _fetchData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    authProvider.currentUser;
    await userProvider.fetchCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final themeProvider = Provider.of<ThemeProvider>(context);
    final user = userProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Registered Events"),
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Registered Events:',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    child: ListView.builder(
                      itemCount: user.registeredEvents.length,
                      itemBuilder: (context, index) {
                        final eventId = user.registeredEvents[index];
                        return _buildEventTile(eventId);
                      },
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildEventTile(String eventId) {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    final qrCodeProvider = Provider.of<QRCodeProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    return FutureBuilder<Event>(
      future: eventProvider.fetchEventById(eventId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListTile(
            title: Text(eventId),
            subtitle: Text('Loading...'),
          );
        } else if (snapshot.hasError) {
          return ListTile(
            title: Text(eventId),
            subtitle: Text('Error: ${snapshot.error}'),
          );
        } else {
          final event = snapshot.data!;
          final user = userProvider.currentUser;
          final qrCode =
              qrCodeProvider.generateTemporaryQRCode(event.id, user!.id);

          return Card(
            child: InkWell(
              onTap: () {
                context.push("/event-details/${event.id}");
              },
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image.asset(
                      'assets/images/moralink_logo.png',
                      height: 40,
                    ),
                    const SizedBox(height: 8),
                    QrImageView(
                      data: "$hostDomain/admin/event-registration/${qrCode.eventId}/${qrCode.userId}",
                      // data: "/admin/event-registration/${qrCode.eventId}/${qrCode.userId}",
                      // data: "${qrCode.eventId},${qrCode.userId}",
                      version: QrVersions.auto,
                      size: 200,
                      dataModuleStyle: QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.square,
                        color: themeProvider.themeMode.name == "dark"
                            ? Colors.white
                            : Colors.black,
                      ),
                      eyeStyle: QrEyeStyle(
                        eyeShape: QrEyeShape.square,
                        color: themeProvider.themeMode.name == "dark"
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      event.title,
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text('Event ID: ${event.id}'),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }
}
