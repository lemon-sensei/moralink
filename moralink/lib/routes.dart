import 'package:flutter/material.dart';
//import 'package:moralink/views/admin/admin_dashboard.dart';
import 'package:moralink/views/auth/login.dart';
import 'package:moralink/views/event/event_details.dart';
import 'package:moralink/views/event/event_list.dart';
import 'package:moralink/views/home.dart';
import 'package:moralink/views/splashScreen.dart';
//import 'package:moralink/views/profile/profile.dart';
//import 'package:moralink/views/settings/settings.dart';

import 'models/event.dart';

class Routes {
  static const String splash = '/';
  static const String login = '/login';
  static const String home = '/home';
  static const String eventList = '/event-list';
  static const String eventDetails = '/event-details';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String adminDashboard = '/admin/dashboard';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case eventList:
        return MaterialPageRoute(builder: (_) => const EventListScreen());
      case eventDetails:
        final args = settings.arguments as EventDetailsScreenArgs;
        return MaterialPageRoute(
          builder: (_) => EventDetailsScreen(event: args.event),
        );
      // case profile:
      //   return MaterialPageRoute(builder: (_) => const ProfileScreen());
      // case settings:
      //   return MaterialPageRoute(builder: (_) => const SettingsScreen());
      // case adminDashboard:
      //   return MaterialPageRoute(builder: (_) => const AdminDashboard());
      default:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
    }
  }
}

class EventDetailsScreenArgs {
  final Event event;

  EventDetailsScreenArgs({required this.event});
}


