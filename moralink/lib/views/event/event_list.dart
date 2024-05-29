// ---------- Common
import 'package:flutter/material.dart';
import 'package:moralink/views/event/widgets/event_card.dart';
import '../../shared/widgets/responsive_layout.dart';

// ---------- Network
import 'package:go_router/go_router.dart';

// ---------- Provider
import 'package:provider/provider.dart';
import 'package:moralink/providers/event_provider.dart';

class EventListScreen extends StatelessWidget {
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);
    final theme = Theme.of(context);
    final textTheme = theme.textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Event List',
          style: textTheme.titleLarge,
        ),
      ),
      body: ResponsiveLayout(
        mobileBody: ListView.builder(
          itemCount: eventProvider.events.length,
          itemBuilder: (context, index) {
            final event = eventProvider.events[index];
            return EventCard(
              event: event,
              onTap: () {
                // Navigate to event details screen
                context.push("/event-details/${event.id}");
              },
            );
          },
        ),
        tabletBody: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          ),
          itemCount: eventProvider.events.length,
          itemBuilder: (context, index) {
            final event = eventProvider.events[index];
            return EventCard(
              event: event,
              onTap: () {
                // Navigate to event details screen
                context.push("/event-details/${event.id}");
              },
            );
          },
        ),
        desktopBody: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 16.0,
            crossAxisSpacing: 16.0,
          ),
          itemCount: eventProvider.events.length,
          itemBuilder: (context, index) {
            final event = eventProvider.events[index];
            return EventCard(
              event: event,
              onTap: () {
                // Navigate to event details screen
                context.push("/event-details/${event.id}");
              },
            );
          },
        ),
      ),
    );
  }
}
