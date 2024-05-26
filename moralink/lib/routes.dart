// ---------- Common
import 'package:flutter/material.dart';
import 'models/event.dart';
import 'package:moralink/models/event_category.dart';
import 'package:moralink/models/location.dart';

// ---------- Screen
import 'package:moralink/views/admin/admin_dashboard.dart';
import 'package:moralink/views/auth/login.dart';
import 'package:moralink/views/event/event_details.dart';
import 'package:moralink/views/event/event_list.dart';
import 'package:moralink/views/home.dart';
import 'package:moralink/views/splash_screen.dart';

// ---------- Network
import 'package:go_router/go_router.dart';

GoRouter get router => _router;

final GoRouter _router = GoRouter(
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const SplashScreen(),
    ),
    GoRoute(
      path: '/login',
      builder: (BuildContext context, GoRouterState state) =>
          const LoginScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (BuildContext context, GoRouterState state) =>
          const HomeScreen(),
    ),
    GoRoute(
      path: '/event-list',
      builder: (BuildContext context, GoRouterState state) =>
          const EventListScreen(),
    ),
    GoRoute(
      path: '/event-details/:eventId',
      builder: (BuildContext context, GoRouterState state) {
        final eventId = state.pathParameters['eventId'];
        // Fetch the event object based on the eventId
        final event = fetchEventFromId(eventId!);
        return EventDetailsScreen(event: event);
      },
    ),
    GoRoute(
      path: '/admin/dashboard',
      builder: (BuildContext context, GoRouterState state) =>
          const AdminDashboard(),
    ),
  ],
);

// A helper method to fetch the event object based on the eventId
Event fetchEventFromId(String eventId) {
  // Implement your logic to fetch the event object based on the eventId
  return Event(
    id: eventId,
    title: 'Example Event',
    description: 'This is an example event.',
    startDate: DateTime(2024, 5, 26, 10, 30),
    endDate: DateTime(2024, 5, 26, 10, 30),
    location: Location(
      name: "Example Location",
      latitude: 000,
      longitude: 000,
      address: "Example Address",
    ),
    category: EventCategory.religious,
    registeredUsers: [],
    // Add other properties as needed
  );
}
