import 'package:flutter/material.dart';
import 'package:moralink/providers/event_provider.dart';
import 'package:provider/provider.dart';

class EventListAdmin extends StatelessWidget {
  const EventListAdmin({super.key});

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
          return ListTile(
            title: Text(event.title),
            subtitle: Text(event.description),
            trailing: IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () {
                // Navigate to update event screen
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigate to create event screen
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}