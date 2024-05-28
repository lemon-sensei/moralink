// ---------- Common
import 'package:flutter/material.dart';
import 'package:moralink/models/event.dart';
import 'package:moralink/repositories/event_repository.dart';
import '../models/user.dart';

class EventProvider extends ChangeNotifier {
  final EventRepository _eventRepository = EventRepository();
  List<Event> _events = [];

  List<Event> get events => _events;

  Future<void> fetchEvents() async {
    _events = await _eventRepository.fetchEvents();
    notifyListeners();
  }

  Future<Event> fetchEventById(String eventId) async {
    return await _eventRepository.fetchEventById(eventId);
  }

  Future<void> registerForEvent(Event event) async {
    await _eventRepository.registerForEvent(event);
    notifyListeners();
  }

  Future<void> markUserAsAttended(Event event, AppUser user) async {
    await _eventRepository.markUserAsAttended(event, user);
    notifyListeners();
  }

// Add other event-related methods as needed
}