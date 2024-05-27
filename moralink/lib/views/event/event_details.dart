// ---------- Common
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moralink/models/event.dart';
import '../../repositories/event_repository.dart';
import '../../shared/widgets/qr_code_viewer.dart';

class EventDetailsScreen extends StatefulWidget {
  final String eventId;

  const EventDetailsScreen({
    super.key,
    required this.eventId,
  });

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  final EventRepository _eventRepository = EventRepository();
  late Event _event;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadEventDetails();
  }

  Future<void> _loadEventDetails() async {
    try {
      final eventData = await _eventRepository.fetchEventById(widget.eventId);
      setState(() {
        _event = eventData;
        _isLoading = false;
      });
    } catch (e) {
      print('Error loading event details: $e');
      // Show an error message or handle the error as needed
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) {
              context.pop();
            } else {
              context.go("/home");
            }
          }, // Use context.pop() to go back
        ),
        title: Text(_isLoading ? 'Loading...' : _event.title),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Display the large image from URL at the top
                    SizedBox(
                      height: 300,
                      child: Image.network(
                        _event.thumbnail,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 16.0),
                    Text(_event.description),
                    const SizedBox(height: 16.0),
                    Text('Start Date: ${_event.startDate}'),
                    const SizedBox(height: 8.0),
                    Text('End Date: ${_event.endDate}'),
                    const SizedBox(height: 16.0),
                    Text('Location: ${_event.locationName}'),
                    Text(_event.locationAddress),
                    const Text('QR Code'),
                    QRCodeViewer(data: _event.id),
                    const SizedBox(height: 16.0),
                    // Add other event details as needed
                  ],
                ),
              ),
            ),
    );
  }
}
