import 'package:flutter/material.dart';
import 'package:moralink/models/event.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Column(
        children: [
          // Event card UI
        ],
      ),
    );
  }
}
