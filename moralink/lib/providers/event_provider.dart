import 'package:flutter/material.dart';
import 'package:moralink/models/event.dart';
import 'package:moralink/repositories/event_repository.dart';

class EventProvider extends ChangeNotifier {
  final EventRepository _eventRepository = EventRepository();
  List<Event> _events = [];

  List<Event> get events => _events;

  Future<void> fetchEvents() async {
    _events = await _eventRepository.fetchEvents();
    notifyListeners();
  }

  Future<void> registerForEvent(Event event) async {
    await _eventRepository.registerForEvent(event);
    notifyListeners();
  }

// Add other event-related methods as needed
}