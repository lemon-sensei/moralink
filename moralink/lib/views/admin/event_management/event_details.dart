// ---------- Common
import 'package:flutter/material.dart';
import 'package:moralink/models/event.dart';
import 'package:moralink/themes/colors.dart';
import 'package:moralink/views/widget/user_badge.dart';
import '../../../models/user.dart';
import '../../../repositories/event_repository.dart';
import '../../../services/screenshot_service.dart';
import '../../../shared/widgets/responsive_layout.dart';

// ---------- Network
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ---------- Provider
import 'package:provider/provider.dart';
import '../../../providers/user_provider.dart';

class EventDetailsScreenAdmin extends StatefulWidget {
  final String eventId;

  const EventDetailsScreenAdmin({
    super.key,
    required this.eventId,
  });

  @override
  State<EventDetailsScreenAdmin> createState() =>
      _EventDetailsScreenAdminState();
}

class _EventDetailsScreenAdminState extends State<EventDetailsScreenAdmin> {
  final EventRepository _eventRepository = EventRepository();
  Event? _event;
  bool _isLoading = true;

  List<AppUser> _enrolledUsers = [];
  List<AppUser> _participatedUsers = [];

  @override
  void initState() {
    super.initState();
    _loadEventDetails();
  }

  Future<void> _loadEventDetails() async {
    try {
      final eventData = await _eventRepository.fetchEventById(widget.eventId);
      final enrolledUsers = await Future.wait(eventData.registeredUsers.map(
          (userId) => Provider.of<UserProvider>(context, listen: false)
              .fetchUserById(userId)));
      final participatedUsers = await Future.wait(eventData.attendedUsers.map(
          (userId) => Provider.of<UserProvider>(context, listen: false)
              .fetchUserById(userId)));
      setState(() {
        _event = eventData;
        _enrolledUsers = enrolledUsers;
        _participatedUsers = participatedUsers;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading event details: $e');
      // Show an error message or handle the error as needed
    }
  }

  Widget _buildUserList(List<AppUser> users, String title) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: Theme.of(context).textTheme.headlineLarge),
        const SizedBox(height: 8),
        Text('Total: ${users.length}',
            style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 8),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: users.length,
          itemBuilder: (context, index) {
            final user = users[index];
            return ListTile(
              leading: CircleAvatar(
                child: Text('${index + 1}'),
              ),
              title: Text('${user.name} (${user.email})'),
              subtitle: Text(user.addressCountry ?? 'Country not specified'),
              onTap: () => _showUserDetailsDialog(context, user),
            );
          },
        ),
      ],
    );
  }

  void _showUserDetailsDialog(BuildContext context, AppUser user) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('User Details'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                    'Name on Passport: ${user.nameOnPassport ?? 'Not provided'}'),
                Text(
                    'Passport Number: ${user.passportNumber ?? 'Not provided'}'),
                Text('Country: ${user.addressCountry ?? 'Not provided'}'),
                const Divider(),
                Text('Phone: ${user.phone ?? 'Not provided'}'),
                Text('Line ID: ${user.lineId ?? 'Not provided'}'),
                const Divider(),
                Text('Name: ${user.name}'),
                Text('Email: ${user.email}'),

                // Text('Registered Events: ${user.registeredEvents.length}'),
                // Text('Attended Events: ${user.attendedEvents.length}'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('Close'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //       builder: (context) => UserBadge(
                //         logoURL: '', // Assuming this is intentionally empty
                //         eventName: _event?.title ?? "Event not specified",
                //         startDate: _event?.startDate ?? DateTime.now(),
                //         endDate: _event?.endDate ?? DateTime.now(),
                //         passportName: user.nameOnPassport ?? "Name not specified",
                //         country: user.addressCountry ?? "Country not specified",
                //         role: user.role.name ?? "Data not specified",
                //         userId: user.id ?? "",
                //         eventId: widget.eventId ?? "",
                //           )),
                // );

                String currentInfo = "Captured at ${DateTime.now()}";

                ScreenshotService.captureAndDownloadWidget(
                  widgetBuilder: (info) => UserBadge(
                    logoURL: '', // Assuming this is intentionally empty
                    eventName: _event?.title ?? "Event not specified",
                    startDate: _event?.startDate ?? DateTime.now(),
                    endDate: _event?.endDate ?? DateTime.now(),
                    passportName: user.nameOnPassport ?? "Name not specified",
                    country: user.addressCountry ?? "Country not specified",
                    role: user.role.name ?? "Data not specified",
                    userId: user.id ?? "",
                    eventId: widget.eventId ?? "",
                  ),
                  information: currentInfo,
                  logicalSize: const Size(1240, 1748),
                  pixelRatio: 1.0,
                  fileName: "${user.name}_badge.png",
                );
              },
              child: const Text('Get user badge'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => UserProvider(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () {
              if (context.canPop()) {
                context.pop();
              } else {
                context.go("/home");
              }
            }, // Use context.pop() to go back
          ),
          title: Text(_isLoading ? 'Loading...' : _event!.title),
          actions: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                context.push("/admin/edit-event/${widget.eventId}");
              },
            ),
          ],
        ),
        body: _isLoading
            ? const Center(child: CircularProgressIndicator())
            : _event!.id != widget.eventId || _event!.id.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text('Event not found'),
                        const SizedBox(height: 16.0),
                        ElevatedButton(
                          onPressed: () {
                            context.go('/home');
                          },
                          child: const Text('Go Home'),
                        ),
                      ],
                    ),
                  )
                : ResponsiveLayout(
                    mobileBody: _buildMobileView(),
                    tabletBody: _buildTabletView(),
                    desktopBody: _buildDesktopView(),
                  ),
      ),
    );
  }

  Widget _buildMobileView() {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 200,
                    child: Image.network(
                      _event!.thumbnail,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Text(
                    _event!.title,
                    style: textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30.0),
            const Divider(),
            const SizedBox(height: 30.0),
            _buildUserList(_enrolledUsers, 'Enrolled Users'),
            const SizedBox(height: 30.0),
            const Divider(),
            const SizedBox(height: 30.0),
            _buildUserList(_participatedUsers, 'Participated Users'),
          ],
        ),
      ),
    );
  }

  Widget _buildTabletView() {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Column(
                children: [
                  SizedBox(
                    height: 300,
                    child: Image.network(
                      _event!.thumbnail,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 30.0),
                  Text(
                    _event!.title,
                    style: textTheme.headlineLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30.0),
            const Divider(),
            const SizedBox(height: 30.0),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: _buildUserList(_enrolledUsers, 'Enrolled Users'),
                ),
                const SizedBox(width: 30.0),
                Expanded(
                  child:
                      _buildUserList(_participatedUsers, 'Participated Users'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopView() {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 400,
                  child: Image.network(
                    _event!.thumbnail,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 30.0),
                Text(
                  _event!.title,
                  style: textTheme.headlineLarge,
                ),
              ],
            ),
          ),
          const SizedBox(width: 32.0),
          Expanded(
            flex: 3,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildUserList(_enrolledUsers, 'Enrolled Users'),
                  const SizedBox(height: 30.0),
                  const Divider(),
                  const SizedBox(height: 30.0),
                  _buildUserList(_participatedUsers, 'Participated Users'),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
