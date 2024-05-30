// ---------- Common
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:moralink/models/event.dart';
import 'package:moralink/models/user_role.dart';
import '../../models/user.dart';
import '../../shared/widgets/responsive_layout.dart';
import '../../themes/colors.dart';
import '../../themes/text_styles.dart';

// ---------- Network
import 'package:go_router/go_router.dart';

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
  late Future<void> _fetchDataFuture;
  bool _isProcessingAttendance = false;

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _fetchData();
  }

  Future<void> _fetchData() async {
    final eventProvider = Provider.of<EventProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    final FirebaseAuth auth = FirebaseAuth.instance;

    if (auth.currentUser == null) {
      context.go('/event-details/${widget.eventId}');
      return;
    } else {
      await userProvider.fetchCurrentUser();

      if (userProvider.currentUser?.role != UserRole.admin) {
        context.go('/event-details/${widget.eventId}');
        return;
      }
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
    final theme = Theme.of(context);
    final textTheme = theme.brightness == Brightness.light
        ? AppTextStyles.lightTextTheme
        : AppTextStyles.darkTextTheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event Registration'),
      ),
      body: FutureBuilder<void>(
        future: _fetchDataFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            return ResponsiveLayout(
              mobileBody: _buildMobileBody(textTheme),
              tabletBody: _buildTabletBody(textTheme),
              desktopBody: _buildDesktopBody(textTheme),
            );
          }
        },
      ),
    );
  }

  Widget _buildMobileBody(TextTheme textTheme) {
    return Center(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "assets/images/moralink_logo.png",
                width: 150,
              ),
              const SizedBox(height: 50),
              if (_event != null)
                Text(
                  _event!.title,
                  style: textTheme.titleLarge,
                  textAlign: TextAlign.center,
                ),
              const SizedBox(height: 25),
              if (_user != null)
                Text(
                  "- ${_user!.name} -",
                  style: textTheme.titleLarge,
                ),
              if (_event == null || _user == null)
                Text(
                  'Loading data...',
                  style: textTheme.titleLarge,
                ),
              const SizedBox(height: 50),
              _buildUserStatus(textTheme),
              const SizedBox(height: 16),
              _buildAttendanceButton(textTheme),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabletBody(TextTheme textTheme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/moralink_logo.png",
              width: 150,
            ),
            const SizedBox(height: 50),
            if (_event != null)
              Text(
                _event!.title,
                style: textTheme.headlineSmall,
              ),
            const SizedBox(height: 25),
            if (_user != null)
              Text(
                "- ${_user!.name} -",
                style: textTheme.headlineSmall,
              ),
            if (_event == null || _user == null)
              Text(
                'Loading data...',
                style: textTheme.headlineSmall,
              ),
            const SizedBox(height: 50),
            _buildUserStatus(textTheme),
            const SizedBox(height: 16),
            _buildAttendanceButton(textTheme),
          ],
        ),
      ),
    );
  }

  Widget _buildDesktopBody(TextTheme textTheme) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(64.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              "assets/images/moralink_logo.png",
              width: 150,
            ),
            const SizedBox(height: 50),
            if (_event != null)
              Text(
                _event!.title,
                style: textTheme.headlineLarge,
              ),
            const SizedBox(height: 25),
            if (_user != null)
              Text(
                "- ${_user!.name} -",
                style: textTheme.headlineLarge,
              ),
            if (_event == null || _user == null)
              Text(
                'Loading data...',
                style: textTheme.headlineLarge,
              ),
            const SizedBox(height: 50),
            _buildUserStatus(textTheme),
            const SizedBox(height: 16),
            _buildAttendanceButton(textTheme),
          ],
        ),
      ),
    );
  }

  Widget _buildUserStatus(TextTheme textTheme) {
    if (_user == null) {
      return Text(
        'No user exists',
        style: textTheme.titleMedium,
      );
    } else if (_event == null) {
      return Text(
        'No event exists',
        style: textTheme.titleMedium,
      );
    } else if (_isUserRegistered == false) {
      return Text(
        'This user has not yet registered for the event',
        style: textTheme.titleMedium,
      );
    } else {
      return Text(
        'This user has registered for this event',
        style: textTheme.titleMedium,
      );
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

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('User marked as attended for the event'),
        ),
      );
    }
  }

  Widget _buildAttendanceButton(TextTheme textTheme) {
    if (_event == null || _user == null) {
      return SizedBox.shrink();
    } else if (_isUserRegistered && !_isUserAttended) {
      return _isProcessingAttendance
          ? const Center(child: CircularProgressIndicator())
          : ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isProcessingAttendance = true;
                });
                await _markUserAsAttended();
                setState(() {
                  _isProcessingAttendance = false;
                });
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
              ),
              child: Text(
                'Mark as Attended',
                style: textTheme.titleLarge?.copyWith(color: Colors.white),
              ),
            );
    } else if (_isUserAttended) {
      return Column(
        children: [
          Text(
            'This user has already attended',
            style: textTheme.titleMedium,
          ),
          const SizedBox(height: 100,),
          Text(
            'Please close this tab manually!',
            style: textTheme.titleLarge,
          ),
        ],
      );
    } else {
      return SizedBox.shrink();
    }
  }
}
