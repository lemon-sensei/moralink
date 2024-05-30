// ---------- Common
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:universal_html/html.dart';
import '../../models/event.dart';
import '../../themes/text_styles.dart';
import '../widget/app_drawer.dart';

// ---------- Network
import 'package:go_router/go_router.dart';

// ---------- Provider
import 'package:provider/provider.dart';
import 'package:moralink/providers/user_provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/event_provider.dart';
import '../../providers/qr_code_provider.dart';
import 'package:moralink/providers/theme_provider.dart';

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

    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    final textTheme =
        isDarkMode ? AppTextStyles.darkTextTheme : AppTextStyles.lightTextTheme;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Registered Events'),
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
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
      drawer: AppDrawer(
        authProvider: authProvider,
        userProvider: userProvider,
      ),
    );
  }

  Widget _buildEventTile(String eventId) {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    final qrCodeProvider = Provider.of<QRCodeProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final themeProvider = Provider.of<ThemeProvider>(context, listen: false);

    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    final textTheme =
        isDarkMode ? AppTextStyles.darkTextTheme : AppTextStyles.lightTextTheme;

    return FutureBuilder<Event>(
      future: eventProvider.fetchEventById(eventId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const ListTile();
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
                    const SizedBox(height: 8),
                    Text(event.title, style: textTheme.titleLarge),
                    const SizedBox(height: 50),
                    QrImageView(
                      embeddedImage: const AssetImage(
                          "assets/images/moralink_logo_white.jpg"),
                      embeddedImageStyle:
                          const QrEmbeddedImageStyle(size: Size(36, 36)),
                      data:
                          "$hostDomain/admin/event-registration/${qrCode.eventId}/${qrCode.userId}",
                      // data: "/admin/event-registration/${qrCode.eventId}/${qrCode.userId}",
                      // data: "${qrCode.eventId},${qrCode.userId}",
                      version: QrVersions.auto,
                      size: 200,
                      dataModuleStyle: QrDataModuleStyle(
                        dataModuleShape: QrDataModuleShape.circle,
                        color: themeProvider.themeMode.name == "dark"
                            ? Colors.white
                            : Colors.black,
                      ),
                      eyeStyle: QrEyeStyle(
                        eyeShape: QrEyeShape.circle,
                        color: themeProvider.themeMode.name == "dark"
                            ? Colors.white
                            : Colors.black,
                      ),
                    ),
                    Text(user.name, style: textTheme.titleLarge),
                    const SizedBox(height: 50),
                    Row(
                      children: [
                        Expanded(
                          child: Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.location_on_rounded),
                                const SizedBox(
                                  width: 10,
                                ),
                                Flexible(
                                  child: Text(
                                    "${event.locationName}, ${event.locationAddress}",
                                    style: textTheme.titleSmall,
                                    overflow: TextOverflow.ellipsis,
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(Icons.date_range_rounded),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                            "${event.startDate.day}/${event.startDate.month}/${event.startDate.year}",
                            style: textTheme.titleMedium),
                      ],
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    Text(
                      'Event ID: ${event.id}',
                      style: textTheme.bodySmall,
                    ),
                    Text(
                      'Event ID: ${user.id}',
                      style: textTheme.bodySmall,
                    ),
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
