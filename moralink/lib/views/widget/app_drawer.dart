// ---------- Common
import 'package:flutter/material.dart';
import 'package:moralink/config/app_config.dart';
import 'package:moralink/models/user_role.dart';
import '../../themes/colors.dart';
import '../../themes/text_styles.dart';

// ---------- Network
import 'package:go_router/go_router.dart';

// ---------- Provider
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';
import 'package:moralink/providers/user_provider.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({
    super.key,
    required this.authProvider,
    required this.userProvider,
  });

  final AuthProvider authProvider;
  final UserProvider userProvider;

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.themeMode == ThemeMode.dark;
    final headerColor =
        isDarkMode ? AppColors.darkScaffoldBackground : AppColors.primary;
    final textTheme =
        isDarkMode ? AppTextStyles.darkTextTheme : AppTextStyles.lightTextTheme;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: headerColor,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/images/moralink_logo.png',
                  height: 60,
                ),
                const SizedBox(height: 16),
                Text(
                  'Welcome, ${authProvider.currentUser?.displayName ?? ''}',
                  style: textTheme.titleLarge,
                ),
                Text(
                  "App version ${AppConfig.appVersion}",
                  style: textTheme.bodySmall,
                ),
              ],
            ),
          ),
          ListTile(
            leading: Icon(Icons.search_rounded,
                color: isDarkMode
                    ? AppColors.darkIconColor
                    : AppColors.lightIconColor),
            title: Text(
              "Browse Events",
              style: textTheme.titleMedium,
            ),
            onTap: () {
              context.go("/home");
            },
          ),
          if (authProvider.currentUser == null)
            ListTile(
              leading: Icon(Icons.login_rounded,
                  color: isDarkMode
                      ? AppColors.darkIconColor
                      : AppColors.lightIconColor),
              title: Text(
                'Sign in',
                style: textTheme.titleMedium,
              ),
              onTap: () {
                context.push("/login");
              },
            ),
          if (authProvider.currentUser != null)
            ListTile(
              leading: Icon(Icons.event_rounded,
                  color: isDarkMode
                      ? AppColors.darkIconColor
                      : AppColors.lightIconColor),
              title: Text(
                'My Events',
                style: textTheme.titleMedium,
              ),
              onTap: () {
                context.push("/my-event");
              },
            ),
          if (authProvider.currentUser != null &&
              userProvider.currentUser?.role == UserRole.admin)
            const Divider(thickness: 1),
          if (authProvider.currentUser != null &&
              userProvider.currentUser?.role == UserRole.admin)
            ListTile(
              title: Text(
                'Admin Panel',
                style: textTheme.titleMedium,
              ),
            ),
          if (authProvider.currentUser != null &&
              userProvider.currentUser?.role == UserRole.admin)
            ListTile(
              leading: Icon(Icons.create_rounded,
                  color: isDarkMode
                      ? AppColors.darkIconColor
                      : AppColors.lightIconColor),
              title: Text(
                "Create New Event",
                style: textTheme.titleMedium,
              ),
              onTap: () {
                context.push("/admin/create-event");
              },
            ),
          if (authProvider.currentUser != null &&
              userProvider.currentUser?.role == UserRole.admin)
            ListTile(
              leading: Icon(Icons.dashboard_rounded,
                  color: isDarkMode
                      ? AppColors.darkIconColor
                      : AppColors.lightIconColor),
              title: Text(
                "Dashboard",
                style: textTheme.titleMedium,
              ),
              onTap: () {
                context.push("/admin/dashboard");
              },
            ),
          const Divider(thickness: 1),
          ListTile(
            leading: Icon(Icons.brightness_6,
                color: isDarkMode
                    ? AppColors.darkIconColor
                    : AppColors.lightIconColor),
            title: Text(
              'Dark Mode',
              style: textTheme.titleMedium,
            ),
            trailing: Switch(
              value: themeProvider.themeMode == ThemeMode.dark,
              onChanged: (value) {
                themeProvider.toggleTheme(value);
                // Save the theme preference here
              },
            ),
          ),
          if (authProvider.currentUser != null)
            ListTile(
              leading: Icon(Icons.person,
                  color: isDarkMode
                      ? AppColors.darkIconColor
                      : AppColors.lightIconColor),
              title: Text(
                'Profile',
                style: textTheme.titleMedium,
              ),
              onTap: () {
                context.push("/profile");
              },
            ),
          if (authProvider.currentUser != null)
            ListTile(
              leading: Icon(Icons.settings,
                  color: isDarkMode
                      ? AppColors.darkIconColor
                      : AppColors.lightIconColor),
              title: Text(
                'Settings',
                style: textTheme.titleMedium,
              ),
              onTap: () {
                context.push("/setting");
              },
            ),
          ListTile(
            leading: Icon(Icons.book_rounded,
                color: isDarkMode
                    ? AppColors.darkIconColor
                    : AppColors.lightIconColor),
            title: Text(
              'User Manual',
              style: textTheme.titleMedium,
            ),
            onTap: () {
              context.push("/manual");
            },
          ),
          ListTile(
            leading: Icon(Icons.settings,
                color: isDarkMode
                    ? AppColors.darkIconColor
                    : AppColors.lightIconColor),
            title: Text(
              'About Us',
              style: textTheme.titleMedium,
            ),
            onTap: () {
              context.push("/about");
            },
          ),
          const Divider(thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextButton(
                  onPressed: () {
                    context.push("/privacy");
                  },
                  child: Text(
                    "Privacy Policy",
                    style: textTheme.titleSmall,
                  )),
              const Text(" • "),
              TextButton(
                  onPressed: () {
                    context.push("/privacy");
                  },
                  child: Text(
                    "Terms of Service",
                    style: textTheme.titleSmall,
                  )),
            ],
          ),
        ],
      ),
    );
  }
}
