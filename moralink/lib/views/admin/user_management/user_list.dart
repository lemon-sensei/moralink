// import 'package:flutter/material.dart';
// import 'package:moralink/models/app_user.dart';
// import 'package:moralink/providers/user_provider.dart';
// import 'package:provider/provider.dart';
//
// class UserListAdmin extends StatelessWidget {
//   const UserListAdmin({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final userProvider = Provider.of<UserProvider>(context);
//
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('User List'),
//       ),
//       body: ListView.builder(
//         itemCount: userProvider.users.length,
//         itemBuilder: (context, index) {
//           final user = userProvider.users[index];
//           return ListTile(
//             title: Text(user.name),
//             subtitle: Text(user.email),
//             trailing: IconButton(
//               icon: const Icon(Icons.visibility),
//               onPressed: () {
//                 // Navigate to user details screen
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }