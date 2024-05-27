import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moralink/models/event.dart';

class EventRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Event>> fetchEvents() async {
    final QuerySnapshot snapshot = await _firestore.collection('events').get();
    return snapshot.docs.map((doc) => Event.fromJson(doc.data() as Map<String, dynamic>)).toList();
  }

  Future<Event> fetchEventById(String eventId) async {
    final DocumentSnapshot snapshot = await _firestore.collection('events').doc(eventId).get();
    return Event.fromJson(snapshot.data() as Map<String, dynamic>);
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

// Add other event-related methods as needed
}