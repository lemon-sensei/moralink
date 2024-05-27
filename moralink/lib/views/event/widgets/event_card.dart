import 'package:flutter/material.dart';
import 'package:moralink/models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;
  final VoidCallback onTap;

  const EventCard({
    super.key,
    required this.event,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: [
            Image.network(
              event.thumbnail,
              height: 200.0, // Adjust the height as needed
              width: double.infinity, // Set the width to match the Card width
              fit: BoxFit.cover,
            ),
            ListTile(
              title: Text(event.title),
              subtitle: Text(event.description),
              onTap: onTap,
            ),
          ],
        ),
      ),
    );
  }
}
