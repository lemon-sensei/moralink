// ---------- Common
import 'package:flutter/material.dart';
import 'package:moralink/models/event.dart';
import '../../models/user.dart';
import '../../repositories/event_repository.dart';
import '../../repositories/qr_code_repository.dart';

// ---------- Network
import 'package:go_router/go_router.dart';
import 'package:firebase_auth/firebase_auth.dart';

// ---------- Provider
import 'package:provider/provider.dart';
import '../../providers/user_provider.dart';

class EventDetailsScreen extends StatefulWidget {
  final String eventId;

  const EventDetailsScreen({
    super.key,
    required this.eventId,
  });

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final EventRepository _eventRepository = EventRepository();
  Event? _event;
  bool _isLoading = true;
  bool _isEnrolled = false;

  @override
  void initState() {
    super.initState();
    _loadEventDetails();
  }

  Future<void> _loadEventDetails() async {
    try {
      final eventData = await _eventRepository.fetchEventById(widget.eventId);
      setState(() {
        _event = eventData;
        _isLoading = false;

        if (FirebaseAuth.instance.currentUser != null && _event != null) {
          _isEnrolled = _event!.registeredUsers
              .contains(FirebaseAuth.instance.currentUser!.uid);
        }
      });
    } catch (e) {
      print('Error loading event details: $e');
      // Show an error message or handle the error as needed
    }
  }

  Future<void> _registerForEvent(BuildContext context) async {
    try {
      // Register the user for the event
      await _eventRepository.registerForEvent(_event!);

      // Get the current user from the UserProvider
      final userProvider = Provider.of<UserProvider>(context, listen: false);
      final currentUser = userProvider.currentUser;

      if (currentUser != null) {
        // Create a new list of registered events by adding the current event ID
        final updatedRegisteredEvents = [
          ...currentUser.registeredEvents,
          _event!.id,
        ];

        // Create a new AppUser instance with the updated registered events
        final updatedUser = AppUser(
          id: currentUser.id,
          name: currentUser.name,
          email: currentUser.email,
          role: currentUser.role,
          registeredEvents: updatedRegisteredEvents,
          attendedEvents: [],
        );

        // Update the user profile in the repository
        await userProvider.updateUserProfile(updatedUser);

        // Generate QR code for the user and event
        // final qrCodeRepository = QRCodeRepository();
        // final qrCode = await qrCodeRepository.generateQRCode(
        //   _event.id,
        //   currentUser.id,
        // );
      }

      // Update the _isEnrolled flag
      setState(() {
        _isEnrolled = true;
      });

      // Show a success message
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Successfully enrolled'),
        ),
      );
    } on FirebaseException catch (e) {
      // Handle Firebase errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Error: ${e.message}'),
        ),
      );
    } catch (e) {
      // Handle other exceptions
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('An error occurred'),
        ),
      );
      print('Error registering for event: $e');
    }
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
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Center(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            // Display the large image from URL at the top
                            SizedBox(
                              height: 300,
                              child: Image.network(
                                _event!.thumbnail,
                                fit: BoxFit.cover,
                              ),
                            ),
                            const SizedBox(height: 16.0),
                            Text(_event!.description),
                            const SizedBox(height: 16.0),
                            Text('Start Date: ${_event!.startDate}'),
                            const SizedBox(height: 8.0),
                            Text('End Date: ${_event!.endDate}'),
                            const SizedBox(height: 16.0),
                            Text('Location: ${_event!.locationName}'),
                            Text(_event!.locationAddress),
                            const SizedBox(height: 16.0),

                            if (FirebaseAuth.instance.currentUser != null)
                              _isEnrolled
                                  ? const Text('You are already registered')
                                  : ElevatedButton(
                                      onPressed: () {
                                        _registerForEvent(context);
                                      },
                                      child: const Text('Enroll'),
                                    ),
                            const SizedBox(height: 16.0),

                            // Add other event details as needed
                          ],
                        ),
                      ),
                    ),
                  ),
      ),
    );
  }
}
