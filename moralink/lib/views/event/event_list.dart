import 'package:flutter/material.dart';
import 'package:moralink/models/event.dart';
import 'package:moralink/providers/event_provider.dart';
import 'package:moralink/views/event/widgets/event_card.dart';
import 'package:provider/provider.dart';

class EventListScreen extends StatelessWidget {
  const EventListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final eventProvider = Provider.of<EventProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Event List'),
      ),
      body: ListView.builder(
        itemCount: eventProvider.events.length,
        itemBuilder: (context, index) {
          final event = eventProvider.events[index];
          return EventCard(
            event: event,
            onTap: () {
              // Navigate to event details screen
            },
          );
        },
      ),
    );
  }
}