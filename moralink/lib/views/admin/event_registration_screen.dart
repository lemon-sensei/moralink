// ---------- Common
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moralink/models/event.dart';
import 'package:moralink/models/user_role.dart';
import '../../models/user.dart';

// ---------- Provider
import 'package:moralink/providers/event_provider.dart';
import 'package:moralink/providers/user_provider.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';

class EventRegistrationScreen extends StatefulWidget {
  final String eventId;
  final String userId;

  const EventRegistrationScreen({
    super.key,
    required this.eventId,
    required this.userId,
  });

  @override
  _EventRegistrationScreenState createState() =>
      _EventRegistrationScreenState();
}

class _EventRegistrationScreenState extends State<EventRegistrationScreen> {
  Event? _event; // Initialize with null
  AppUser? _user; // Initialize with null
  bool _isUserRegistered = false;
  bool _isUserAttended = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    if (userProvider.currentUser?.role != UserRole.admin) {
      context.go('/event-details/${widget.eventId}');
      return;
    }

    _event = await eventProvider.fetchEventById(widget.eventId);
    _user = await userProvider.fetchUserById(widget.userId);

    if (_event != null && _user != null) {
      _isUserRegistered = _event!.registeredUsers.contains(_user!.id);
      _isUserAttended = _user!.attendedEvents.contains(_event!.id);
    }

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event Registration'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (_event != null) Text('Event: ${_event!.title}'),
            if (_event == null || _user == null) Text('Loading data...'),
            SizedBox(height: 16),
            _buildUserStatus(),
            SizedBox(height: 16),
            _buildAttendanceButton(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserStatus() {
    if (_user == null) {
      return Text('No user exists');
    } else if (_event == null) {
      return Text('No event exists');
    } else if (_isUserRegistered == false) {
      return Text('This user has not yet registered for the event');
    } else {
      return Text('This user is registered for the event');
    }
  }

  Widget _buildAttendanceButton() {
    if (_event == null || _user == null) {
      return SizedBox.shrink(); // Return an empty widget if data is not loaded
    } else if (_isUserRegistered && !_isUserAttended) {
      return ElevatedButton(
        onPressed: _markUserAsAttended,
        child: Text('Mark as Attended'),
      );
    } else if (_isUserAttended) {
      return Text('This user has already attended');
    } else {
      return SizedBox.shrink();
    }
  }

  Future<void> _markUserAsAttended() async {
    if (_event != null && _user != null) {
      final eventProvider = Provider.of<EventProvider>(context, listen: false);
      final userProvider = Provider.of<UserProvider>(context, listen: false);

      await eventProvider.markUserAsAttended(_event!, _user!);
      await userProvider.markEventAsAttended(_event!, _user!);

      setState(() {
        _isUserAttended = true;
      });
    }
  }
}
