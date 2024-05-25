import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:moralink/models/event.dart';

class EventRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<List<Event>> fetchEvents() async {
    final QuerySnapshot snapshot = await _firestore.collection('events').get();
    return snapshot.docs.map((doc) => Event.fromJson(doc.data() as Map<String, dynamic>)).toList();
  }

  Future<void> registerForEvent(Event event) async {
    final String userId = FirebaseAuth.instance.currentUser!.uid;
    await _firestore.collection('events').doc(event.id).update({
      'registeredUsers': FieldValue.arrayUnion([userId]),
    });
  }

// Add other event-related methods as needed
}