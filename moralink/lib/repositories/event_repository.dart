// ---------- Common
import 'package:moralink/models/event.dart';
import 'package:moralink/models/event_category.dart';
import '../models/user.dart';

// ---------- Network
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class EventRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Event>> fetchEvents() async {
    final QuerySnapshot snapshot = await _firestore.collection('events').get();
    return snapshot.docs.map((doc) => Event.fromJson(doc.data() as Map<String, dynamic>)).toList();
  }

  Future<Event> fetchEventById(String eventId) async {
    final DocumentSnapshot snapshot = await _firestore.collection('events').doc(eventId).get();

    if (snapshot.exists) {
      return Event.fromJson(snapshot.data() as Map<String, dynamic>);
    } else {
      // Return an Event object with default values if the document does not exist
      return Event(
        id: '',
        title: 'Event Not Found',
        description: 'No event found with the specified ID',
        thumbnail: 'https://path/to/default/thumbnail.jpg',
        startDate: DateTime.now(),
        endDate: DateTime.now().add(const Duration(days: 1)),
        locationName: 'Default Location',
        locationAddress: '',
        locationLat: 0.0,
        locationLong: 0.0,
        category: EventCategory.religious,
        registeredUsers: [],
        attendedUsers: [],
      );
    }

  }



  Future<void> registerForEvent(Event event) async {
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    await _firestore.collection('events').doc(event.id).update({
      'registeredUsers': FieldValue.arrayUnion([userId]),
    });
  }

  Future<void> addEvent(Event event) async {
    try {
      final eventData = event.toJson();
      print('Event data: $eventData'); // Print the event data for debugging

      await _firestore.collection('events').doc(event.id).set(eventData);
    } catch (e, stackTrace) {
      print('Error adding event: $e');
      print('Stack trace: $stackTrace');
      throw Exception('Error adding event: $e');
    }
  }

  Future<void> markUserAsAttended(Event event, AppUser user) async {
    await _firestore.collection('events').doc(event.id).update({
      'attendedUsers': FieldValue.arrayUnion([user.id]),
    });
  }

  Future<void> updateEvent(Event event) async {
    try {
      final eventData = event.toJson();
      await _firestore.collection('events').doc(event.id).update(eventData);
    } catch (e, stackTrace) {
      print('Error updating event: $e');
      print('Stack trace: $stackTrace');
      throw Exception('Error updating event: $e');
    }
  }

// Add other event-related methods as needed
}