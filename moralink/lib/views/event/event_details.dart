import 'package:flutter/material.dart';
import 'package:moralink/models/event.dart';
import '../../shared/widgets/qr_code_viewer.dart';

class EventDetailsScreen extends StatelessWidget {
  final Event event;

  const EventDetailsScreen({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(event.title),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                event.description,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              const SizedBox(height: 16.0),
              Text('Date: ${event.startDate.toString()}'),
              Text('Time: ${event.startDate.toString()}'),
              Text('Location: ${event.locationName}'),
              const SizedBox(height: 16.0),
              const Text('QR Code'),
              const QRCodeViewer(data: 'dummy_qr_code_data'),
              // Add other event details
            ],
          ),
        ),
      ),
    );
  }
}
