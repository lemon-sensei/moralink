// ---------- Common
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:moralink/themes/colors.dart';
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';
import '../../shared/widgets/responsive_layout.dart';
import '../widget/app_drawer.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;
    final bool isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return ResponsiveLayout(
      mobileBody: _buildAboutContent(context, textTheme, isDarkMode,
          constraints: const BoxConstraints(maxWidth: 600)),
      tabletBody: _buildAboutContent(context, textTheme, isDarkMode,
          constraints: const BoxConstraints(maxWidth: 800)),
      desktopBody: _buildAboutContent(context, textTheme, isDarkMode,
          constraints: const BoxConstraints(maxWidth: 1200)),
    );
  }

  Widget _buildAboutContent(
      BuildContext context, TextTheme textTheme, bool isDarkMode,
      {required BoxConstraints constraints}) {
    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('About Moralink'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 800),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/moralink_logo.png",
                    width: 150,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Our Story',
                    style: textTheme.headlineLarge
                        ?.copyWith(color: isDarkMode ? AppColors.accent : null),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Moralink was born out of a passion for technology and a desire to simplify the way people connect. Our founders, two tech enthusiasts with a shared vision, set out to create a platform that would revolutionize the way we communicate and collaborate.',
                    style: textTheme.bodyLarge
                        ?.copyWith(color: isDarkMode ? Colors.white : null),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'At Moralink, we believe that communication should be effortless and accessible to everyone. That\'s why we\'ve worked tirelessly to develop a user-friendly platform that combines cutting-edge technology with intuitive design. Our goal is to empower individuals and businesses alike, fostering connections that transcend borders and barriers.',
                    style: textTheme.bodyLarge
                        ?.copyWith(color: isDarkMode ? Colors.white : null),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 32),
                  Text(
                    'Through continuous innovation and a commitment to excellence, Moralink has grown into a thriving community of users from all walks of life. We take pride in our diverse and inclusive culture, where ideas and perspectives are celebrated. Join us on this exciting journey as we continue to push the boundaries of what\'s possible, connecting people and unlocking new opportunities for growth and collaboration.',
                    style: textTheme.bodyLarge
                        ?.copyWith(color: isDarkMode ? Colors.white : null),
                    textAlign: TextAlign.justify,
                  ),
                  const SizedBox(height: 32),
                  ElevatedButton(
                    onPressed: () {
                      context.push("/home");
                    },
                    child: Text(
                      "Go Back",
                      style: textTheme.bodyLarge,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ),
      ),
      drawer: AppDrawer(
        authProvider: authProvider,
        userProvider: userProvider,
      ),
    );
  }
}
