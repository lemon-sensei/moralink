// ---------- Common
import 'package:flutter/material.dart';
import 'package:moralink/models/event.dart';
import 'package:moralink/repositories/event_repository.dart';
import '../models/user.dart';

class EventProvider extends ChangeNotifier {
  final EventRepository _eventRepository = EventRepository();
  List<Event> _events = [];
  bool _isLoading = true;

  List<Event> get events => _events;
  bool get isLoading => _isLoading;

  Future<void> fetchEvents() async {
    _isLoading = true;
    notifyListeners();

    try {
      _events = (await _eventRepository.fetchEvents()).reversed.toList();
    } catch (e) {
      // Handle any errors
      print('Error fetching events: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
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