// ---------- Common
import 'package:flutter/material.dart';

// ---------- Network
import 'package:go_router/go_router.dart';

// ---------- Provider
import 'package:provider/provider.dart';
import 'package:moralink/providers/user_provider.dart';
import '../../providers/auth_provider.dart';
import '../../themes/colors.dart';

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  bool _showSuccessMessage = false;

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    final authProvider = Provider.of<AuthProvider>(context, listen: false);
    final userProvider = Provider.of<UserProvider>(context, listen: false);

    authProvider.currentUser;
    await userProvider.fetchCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);
    final user = userProvider.currentUser;
    final textTheme = Theme.of(context).textTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('User Profile'),
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 32),
                    Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.transparent,
                        radius: 60,
                        backgroundImage: user.photoUrl != null
                            ? NetworkImage(user.photoUrl!)
                            : const AssetImage(
                                    'assets/images/moralink_logo.png')
                                as ImageProvider,
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: 400,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Name: ${user.name}',
                                style: textTheme.titleLarge,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Email: ${user.email}',
                                style: textTheme.titleLarge,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                'Role: ${user.role.name}',
                                style: textTheme.titleLarge,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: 400,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Contact',
                                style: textTheme.titleLarge,
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: TextEditingController(
                                  text: user.phone ?? '',
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Phone',
                                  labelStyle: textTheme.bodyMedium,
                                ),
                                style: textTheme.bodyMedium,
                                onChanged: (value) {
                                  // Update the passport number in the user object
                                  user.phone = value;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: TextEditingController(
                                  text: user.lineId ?? '',
                                ),
                                decoration: InputDecoration(
                                  labelText: 'LINE ID',
                                  labelStyle: textTheme.bodyMedium,
                                ),
                                style: textTheme.bodyMedium,
                                onChanged: (value) {
                                  // Update the name on passport in the user object
                                  user.lineId = value;
                                },
                              ),
                              const SizedBox(height: 16),
                              Visibility(
                                visible: _showSuccessMessage,
                                child: Text(
                                  'Information updated successfully!',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue, // Set the background color to blue
                                ),
                                onPressed: () async {
                                  // Update the user profile in the database
                                  await userProvider.updateUserProfile(user);
                                  setState(() {
                                    _showSuccessMessage = true;
                                  });
                                },
                                child: Text(
                                  'Update',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: 400,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                'Passport Detail',
                                style: textTheme.titleLarge,
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: TextEditingController(
                                  text: user.passportNumber ?? '',
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Passport Number',
                                  labelStyle: textTheme.bodyMedium,
                                ),
                                style: textTheme.bodyMedium,
                                onChanged: (value) {
                                  // Update the passport number in the user object
                                  user.passportNumber = value;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: TextEditingController(
                                  text: user.nameOnPassport ?? '',
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Name on Passport',
                                  labelStyle: textTheme.bodyMedium,
                                ),
                                style: textTheme.bodyMedium,
                                onChanged: (value) {
                                  // Update the name on passport in the user object
                                  user.nameOnPassport = value;
                                },
                              ),
                              const SizedBox(height: 16),
                              Visibility(
                                visible: _showSuccessMessage,
                                child: Text(
                                  'Information updated successfully!',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: Colors.green,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.blue, // Set the background color to blue
                                ),
                                onPressed: () async {
                                  // Update the user profile in the database
                                  await userProvider.updateUserProfile(user);
                                  setState(() {
                                    _showSuccessMessage = true;
                                  });
                                },
                                child: Text(
                                  'Update',
                                  style: textTheme.bodyMedium?.copyWith(
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 32),
                    SizedBox(
                      width: 400,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Center(
                                child: Text(
                                  'Physical Address',
                                  style: textTheme.titleLarge,
                                ),
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: TextEditingController(
                                  text: user.addressLine1 ?? '',
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Address Line 1',
                                  labelStyle: textTheme.bodyMedium,
                                ),
                                style: textTheme.bodyMedium,
                                onChanged: (value) {
                                  // Update the address line 1 in the user object
                                  user.addressLine1 = value;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: TextEditingController(
                                  text: user.addressLine2 ?? '',
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Address Line 2',
                                  labelStyle: textTheme.bodyMedium,
                                ),
                                style: textTheme.bodyMedium,
                                onChanged: (value) {
                                  // Update the address line 2 in the user object
                                  user.addressLine2 = value;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: TextEditingController(
                                  text: user.addressCity ?? '',
                                ),
                                decoration: InputDecoration(
                                  labelText: 'City',
                                  labelStyle: textTheme.bodyMedium,
                                ),
                                style: textTheme.bodyMedium,
                                onChanged: (value) {
                                  // Update the city in the user object
                                  user.addressCity = value;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: TextEditingController(
                                  text: user.addressState ?? '',
                                ),
                                decoration: InputDecoration(
                                  labelText: 'State/Province',
                                  labelStyle: textTheme.bodyMedium,
                                ),
                                style: textTheme.bodyMedium,
                                onChanged: (value) {
                                  // Update the state/province in the user object
                                  user.addressState = value;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: TextEditingController(
                                  text: user.addressZipCode ?? '',
                                ),
                                decoration: InputDecoration(
                                  labelText: 'ZIP/Postal Code',
                                  labelStyle: textTheme.bodyMedium,
                                ),
                                style: textTheme.bodyMedium,
                                onChanged: (value) {
                                  // Update the ZIP/postal code in the user object
                                  user.addressZipCode = value;
                                },
                              ),
                              const SizedBox(height: 16),
                              TextField(
                                controller: TextEditingController(
                                  text: user.addressCountry ?? '',
                                ),
                                decoration: InputDecoration(
                                  labelText: 'Country',
                                  labelStyle: textTheme.bodyMedium,
                                ),
                                style: textTheme.bodyMedium,
                                onChanged: (value) {
                                  user.addressCountry = value;
                                },
                              ),
                              const SizedBox(height: 16),
                              Center(
                                child: Visibility(
                                  visible: _showSuccessMessage,
                                  child: Text(
                                    'Information updated successfully!',
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: Colors.green,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 16),
                              Center(
                                child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.blue, // Set the background color to blue
                                  ),
                                  onPressed: () async {
                                    // Update the user profile in the database
                                    await userProvider.updateUserProfile(user);
                                    setState(() {
                                      _showSuccessMessage = true;
                                    });
                                  },
                                  child: Text(
                                    'Update',
                                    style: textTheme.bodyMedium?.copyWith(
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 50),
                    Text(
                      'View your upcoming events',
                      style: textTheme.titleLarge,
                    ),
                    const SizedBox(height: 10),
                    ElevatedButton(
                      onPressed: () {
                        context.push("/my-event");
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primary),
                      child: Text(
                        'Go to My Events',
                        style: textTheme.bodyLarge,
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
    );
  }
}
