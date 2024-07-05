// ---------- Common
import 'package:flutter/material.dart';
import 'package:moralink/models/event.dart';
import 'package:moralink/themes/colors.dart';
import '../../../models/user.dart';
import '../../../repositories/event_repository.dart';
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
        Text('Total: ${users.length}', style: Theme.of(context).textTheme.titleLarge),
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
            );
          },
        ),
      ],
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
                  child: _buildUserList(_participatedUsers, 'Participated Users'),
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
