// ---------- Common
import 'package:flutter/material.dart';


// ---------- Provider
import 'package:provider/provider.dart';
import 'package:moralink/models/user.dart';
import 'package:moralink/providers/user_provider.dart';
import '../../providers/auth_provider.dart';

class UserProfileScreen extends StatelessWidget {
  const UserProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    //final userProvider = Provider.of<UserProvider>(context);
    // final user = userProvider.currentUser;

    final authProvider = Provider.of<AuthProvider>(context);
    final user = authProvider.currentUser;

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Profile'),
      ),
      // body: user == null
      //     ? const Center(child: CircularProgressIndicator())
      //     : Padding(
      //   padding: const EdgeInsets.all(16.0),
      //   child: Column(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Text(
      //         'Name: ${user.name}',
      //         style: const TextStyle(fontSize: 18),
      //       ),
      //       const SizedBox(height: 8),
      //       Text(
      //         'Email: ${user.email}',
      //         style: const TextStyle(fontSize: 18),
      //       ),
      //       const SizedBox(height: 8),
      //       Text(
      //         'Role: ${user.role.name}',
      //         style: const TextStyle(fontSize: 18),
      //       ),
      //       const SizedBox(height: 16),
      //       const Text(
      //         'Registered Events:',
      //         style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      //       ),
      //       const SizedBox(height: 8),
      //       Expanded(
      //         child: ListView.builder(
      //           itemCount: user.registeredEvents.length,
      //           itemBuilder: (context, index) {
      //             final eventId = user.registeredEvents[index];
      //             return ListTile(
      //               title: Text(eventId),
      //               trailing: IconButton(
      //                 icon: const Icon(Icons.qr_code),
      //                 onPressed: () {
      //                   // Show QR code for the event
      //                 },
      //               ),
      //             );
      //           },
      //         ),
      //       ),
      //       const SizedBox(height: 16),
      //       ElevatedButton(
      //         onPressed: () {
      //           // Sign out logic
      //         },
      //         child: const Text('Sign Out'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}