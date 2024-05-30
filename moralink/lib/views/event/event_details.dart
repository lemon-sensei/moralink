// ---------- Common
import 'package:flutter/material.dart';
import 'package:moralink/models/event.dart';
import 'package:moralink/providers/theme_provider.dart';
import 'package:moralink/themes/colors.dart';
import '../../models/user.dart';
import '../../repositories/event_repository.dart';
import '../../shared/widgets/responsive_layout.dart';
import '../../themes/text_styles.dart';

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
  bool _isEnrolling = false;

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
    setState(() {
      _isEnrolling = true; // Set _isEnrolling to true before registration
    });

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
    } finally {
      setState(() {
        _isEnrolling = false; // Set _isEnrolling to false after registration
      });
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
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Display the large image from URL at the top
              SizedBox(
                height: 200,
                child: Image.network(
                  _event!.thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
              const SizedBox(height: 30.0),
              Text(
                _event!.description,
                style: textTheme.bodyLarge,
              ),
              const SizedBox(height: 30.0),
              Column(
                children: [
                  const Icon(Icons.date_range_rounded),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${_event!.startDate.day}/${_event!.startDate.month}/${_event!.startDate.year} - ${_event!.endDate.day}/${_event!.endDate.month}/${_event!.endDate.year}',
                    style: textTheme.bodyLarge,
                  ),
                ],
              ),

              const SizedBox(height: 30),
              Column(

                children: [
                  const Icon(Icons.location_on_rounded),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    _event!.locationName,
                    style: textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    _event!.locationAddress,
                    style: textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              const SizedBox(height: 50.0),
              if (FirebaseAuth.instance.currentUser == null)
                Column(
                  children: [
                    Text(
                      'Please login to participate the event',
                      style: textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.push("/login");
                      },
                      child: Text(
                        'Sign in',
                        style: textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              if (FirebaseAuth.instance.currentUser != null)
                _isEnrolled
                    ? Column(
                        children: [
                          Text(
                            'You are already registered',
                            style: textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context.push("/my-event");
                            },
                            child: Text(
                              'Go to My Events',
                              style: textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      )
                    : _isEnrolling
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: 200,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                _registerForEvent(context);
                              },
                              child: Text(
                                'Enroll',
                                style: textTheme.bodyLarge,
                              ),
                            ),
                          ),
              const SizedBox(height: 16.0),
            ],
          ),
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
              const SizedBox(height: 30.0),
              Text(
                _event!.description,
                style: textTheme.bodyLarge,
              ),
              const SizedBox(height: 30.0),
              Column(
                children: [
                  const Icon(Icons.date_range_rounded),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    '${_event!.startDate.day}/${_event!.startDate.month}/${_event!.startDate.year} - ${_event!.endDate.day}/${_event!.endDate.month}/${_event!.endDate.year}',
                    style: textTheme.bodyLarge,
                  ),
                ],
              ),

              const SizedBox(height: 30),
              Column(
                children: [
                  const Icon(Icons.location_on_rounded),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    _event!.locationName,
                    style: textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    _event!.locationAddress,
                    style: textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),

              const SizedBox(height: 50.0),
              if (FirebaseAuth.instance.currentUser == null)
                Column(
                  children: [
                    Text(
                      'Please login to participate the event',
                      style: textTheme.titleLarge,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        context.push("/login");
                      },
                      child: Text(
                        'Sign in',
                        style: textTheme.bodyLarge,
                      ),
                    ),
                  ],
                ),
              if (FirebaseAuth.instance.currentUser != null)
                _isEnrolled
                    ? Column(
                        children: [
                          Text(
                            'You are already registered',
                            style: textTheme.titleLarge,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          ElevatedButton(
                            onPressed: () {
                              context.push("/my-event");
                            },
                            child: Text(
                              'Go to My Events',
                              style: textTheme.bodyLarge,
                            ),
                          ),
                        ],
                      )
                    : _isEnrolling
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: 200,
                            height: 50,
                            child: ElevatedButton(
                              onPressed: () {
                                _registerForEvent(context);
                              },
                              child: Text(
                                'Enroll',
                                style: textTheme.bodyLarge,
                              ),
                            ),
                          ),
              const SizedBox(height: 16.0),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDesktopView() {
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Center(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              child: SizedBox(
                height: 500,
                child: Image.network(
                  _event!.thumbnail,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 32.0),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _event!.title,
                      style: textTheme.headlineLarge,
                    ),
                    const SizedBox(height: 16.0),
                    Text(
                      _event!.description,
                      style: textTheme.bodyLarge,
                    ),
                    const SizedBox(height: 30.0),
                    Row(
                      children: [
                        const Icon(Icons.date_range_rounded),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          '${_event!.startDate.day}/${_event!.startDate.month}/${_event!.startDate.year} - ${_event!.endDate.day}/${_event!.endDate.month}/${_event!.endDate.year}',
                          style: textTheme.bodyLarge,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Row(
                      children: [
                        const Icon(Icons.location_on_rounded),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          _event!.locationName,
                          style: textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          _event!.locationAddress,
                          style: textTheme.bodyLarge,
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 50.0),
                    if (FirebaseAuth.instance.currentUser == null)
                      Column(
                        children: [
                          Center(
                            child: Text(
                              'Please login to participate the event',
                              style: textTheme.titleLarge,
                            ),
                          ),
                          const Center(
                            child: SizedBox(
                              height: 10,
                            ),
                          ),
                          Center(
                            child: ElevatedButton(
                              onPressed: () {
                                context.push("/login");
                              },
                              child: Text(
                                'Sign in',
                                style: textTheme.bodyLarge,
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (FirebaseAuth.instance.currentUser != null)
                      _isEnrolled
                          ? Column(
                              children: [
                                Center(
                                  child: Text(
                                    'You are already registered',
                                    style: textTheme.titleLarge,
                                  ),
                                ),
                                const Center(
                                  child: SizedBox(
                                    height: 10,
                                  ),
                                ),
                                Center(
                                  child: ElevatedButton(
                                    onPressed: () {
                                      context.push("/my-event");
                                    },
                                    child: Text(
                                      'Go to My Events',
                                      style: textTheme.bodyLarge,
                                    ),
                                  ),
                                ),
                              ],
                            )
                          : _isEnrolling
                              ? const CircularProgressIndicator()
                              : Center(
                                child: SizedBox(
                                    width: 200,
                                    height: 50,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        _registerForEvent(context);
                                      },
                                      child: Text(
                                        'Enroll',
                                        style: textTheme.bodyLarge,
                                      ),
                                    ),
                                  ),
                              ),
                    const SizedBox(height: 16.0),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
