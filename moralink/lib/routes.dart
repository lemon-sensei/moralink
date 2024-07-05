// ---------- Common
import 'package:flutter/material.dart';
import 'package:moralink/views/about/privacy.dart';

// ---------- Screen
import 'package:moralink/views/admin/admin_dashboard.dart';
import 'package:moralink/views/admin/event_management/event_details.dart';
import 'package:moralink/views/admin/event_management/event_edit.dart';
import 'package:moralink/views/admin/event_management/event_list.dart';
import 'package:moralink/views/auth/login.dart';
import 'package:moralink/views/event/event_details.dart';
import 'package:moralink/views/event/event_list.dart';
import 'package:moralink/views/manual/user_manual_screen.dart';
import 'package:moralink/views/not_found/not_found_screen.dart';
import 'package:moralink/views/profile/my_event.dart';
import 'package:moralink/views/home/home.dart';
import 'package:moralink/views/settings/setting_screen.dart';
import 'package:moralink/views/about/about_screen.dart';
import 'package:moralink/views/splash/splash_screen.dart';
import 'package:moralink/views/profile/user_profile.dart';
import 'package:moralink/views/admin/event_management/event_create.dart';
import 'package:moralink/views/admin/event_registration_screen.dart';
import 'package:moralink/views/admin/qr_code_scanner_screen.dart';

// ---------- Network
import 'package:go_router/go_router.dart';

GoRouter get router => _router;

final GoRouter _router = GoRouter(
  errorBuilder: (context, state) => const NotFoundScreen(),
  routes: <GoRoute>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) =>
          const SplashScreen(),
    ),
    GoRoute(
      path: '/privacy',
      builder: (BuildContext context, GoRouterState state) =>
      const PrivacyScreen(),
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
      path: '/setting',
      builder: (BuildContext context, GoRouterState state) =>
          const SettingScreen(),
    ),
    GoRoute(
      path: '/manual',
      builder: (BuildContext context, GoRouterState state) =>
          const UserManualScreen(),
    ),
    GoRoute(
      path: '/about',
      builder: (BuildContext context, GoRouterState state) =>
          const AboutScreen(),
    ),
    GoRoute(
      path: '/admin/dashboard',
      builder: (BuildContext context, GoRouterState state) =>
          const AdminDashboard(),
    ),
    GoRoute(
      path: '/admin/qr-code-scanner',
      builder: (BuildContext context, GoRouterState state) =>
          const QRCodeScannerScreen(),
    ),
    GoRoute(
      path: '/admin/create-event',
      builder: (BuildContext context, GoRouterState state) =>
          const EventCreateAdmin(),
    ),
    GoRoute(
      path: '/admin/event-list',
      builder: (BuildContext context, GoRouterState state) =>
          const EventListAdmin(),
    ),
    GoRoute(
      path: '/admin/event-details/:eventId',
      builder: (BuildContext context, GoRouterState state) {
        final eventId = state.pathParameters['eventId'];

        return EventDetailsScreenAdmin(eventId: eventId!);
      },
    ),
    GoRoute(
      path: '/admin/edit-event/:eventId',
      builder: (BuildContext context, GoRouterState state) =>
          EventEditAdmin(eventId: state.pathParameters['eventId']!),
    ),
    GoRoute(
      path: '/admin/event-registration/:eventId/:userId',
      builder: (BuildContext context, GoRouterState state) {
        final eventId = state.pathParameters['eventId'];
        final userId = state.pathParameters['userId'];

        return EventRegistrationScreen(
          eventId: eventId!,
          userId: userId!,
        );
      },
    ),
  ],
);
