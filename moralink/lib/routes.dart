// ---------- Common
import 'package:flutter/material.dart';
import 'models/event.dart';
import 'package:moralink/models/event_category.dart';

// ---------- Screen
import 'package:moralink/views/admin/admin_dashboard.dart';
import 'package:moralink/views/auth/login.dart';
import 'package:moralink/views/event/event_details.dart';
import 'package:moralink/views/event/event_list.dart';
import 'package:moralink/views/profile/my_event.dart';
import 'package:moralink/views/home.dart';
import 'package:moralink/views/splash_screen.dart';
import 'package:moralink/views/profile/user_profile.dart';
import 'package:moralink/views/admin/event_management/event_create.dart';

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
      path: '/profile',
      builder: (BuildContext context, GoRouterState state) =>
          const UserProfileScreen(),
    ),
    GoRoute(
      path: '/my-event',
      builder: (BuildContext context, GoRouterState state) =>
      const MyEventScreen(),
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

        return EventDetailsScreen(eventId: eventId!);
      },
    ),
    GoRoute(
      path: '/admin/dashboard',
      builder: (BuildContext context, GoRouterState state) =>
          const AdminDashboard(),
    ),
    GoRoute(
      path: '/admin/create-event',
      builder: (BuildContext context, GoRouterState state) =>
          const EventCreateAdmin(),
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
    thumbnail: "https://www.facebook.com/photo/?fbid=341509057548869&set=a.462114586014626",
    startDate: DateTime(2024, 5, 26, 10, 30),
    endDate: DateTime(2024, 5, 26, 10, 30),
    locationName: "Sample Location",
    locationAddress: "Sample Location Address",
    locationLat: 000,
    locationLong: 000,
    category: EventCategory.religious,
    registeredUsers: [],
    // Add other properties as needed
  );
}
