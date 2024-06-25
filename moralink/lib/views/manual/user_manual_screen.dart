// ---------- Common
import 'package:flutter/material.dart';
import 'package:moralink/themes/text_styles.dart';
import '../../shared/widgets/responsive_layout.dart';
import '../widget/app_drawer.dart';

// ---------- Provider
import 'package:provider/provider.dart';
import '../../providers/auth_provider.dart';
import '../../providers/user_provider.dart';

class UserManualScreen extends StatelessWidget {
  const UserManualScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final textTheme =
        isDarkMode ? AppTextStyles.darkTextTheme : AppTextStyles.lightTextTheme;

    return ResponsiveLayout(
      mobileBody: _buildManualContent(context, textTheme),
      tabletBody: _buildManualContent(context, textTheme),
      desktopBody: _buildManualContent(context, textTheme),
    );
  }

  Widget _buildManualContent(BuildContext context, TextTheme textTheme) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;
    final backgroundColor = isDarkMode ? Colors.black : Colors.white;
    final fontColor = isDarkMode ? Colors.white : Colors.black;

    final authProvider = Provider.of<AuthProvider>(context);
    final userProvider = Provider.of<UserProvider>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
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
                  Center(
                    child: Text(
                      'User Guide',
                      style:
                          textTheme.headlineLarge?.copyWith(color: fontColor),
                    ),
                  ),
                  const SizedBox(height: 50),
                  _buildSection(
                    textTheme,
                    'assets/manual/login-screen.png',
                    "User authentication",
                    'To use the full functionality of the application, a user must authenticate in order the system to identify and store data properly. This could achieve by using Google credential from your Gmail account. In order to start the authentication process, user just simply click on the "Sign in with Google" button. The prompt windows will immediately pop on the screen, from now on just select which Gmail account you want to link into our system.',
                    fontColor,
                    [],
                  ),
                  const SizedBox(height: 50),
                  const Divider(thickness: 2.0, color: Colors.grey),
                  const SizedBox(height: 50),
                  _buildSection(
                    textTheme,
                    'assets/manual/profile-screen.png',
                    "Update user profile",
                    'User may need to update the bundle identification on this screen, such as Passport number or full name on Passport in order to participate in some event. User may required to provide their personal information to the management team of the event to enroll as an officially participant. User can update their required information in this screen and it will only send to the event manager when they officially request for.',
                    fontColor,
                    [],
                  ),
                  const SizedBox(height: 50),
                  const Divider(thickness: 2.0, color: Colors.grey),
                  const SizedBox(height: 50),
                  _buildSection(
                    textTheme,
                    'assets/manual/enroll-screen.png',
                    "Enroll the an event",
                     "",
                     fontColor,
                    [],
                  ),
                  const SizedBox(height: 50),
                  const Divider(thickness: 2.0, color: Colors.grey),
                  const SizedBox(height: 50),
                  _buildSection(
                    textTheme,
                    'assets/manual/my-qr-screen.png',
                    "Attend to the event",
                    "",
                    fontColor,
                    [],
                  ),
                  const SizedBox(height: 50),
                  const Divider(thickness: 2.0, color: Colors.grey),
                  const SizedBox(height: 50),
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

  Widget _buildSection(
    TextTheme textTheme,
    String imagePath,
    String topic,
    String paragraph,
    Color fontColor,
    List<String> bulletPoints,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Center(
          child: Text(
            topic,
            style: textTheme.titleLarge?.copyWith(color: fontColor),
            textAlign: TextAlign.justify,
          ),
        ),
        const SizedBox(height: 50),
        Image.asset(
          imagePath,
          fit: BoxFit.contain,
        ),
        const SizedBox(height: 16.0),
        Text(
          paragraph,
          style: textTheme.bodyLarge?.copyWith(color: fontColor),
          textAlign: TextAlign.justify,
        ),
        const SizedBox(height: 8.0),
        ...bulletPoints.map((point) => Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '• ',
                  style: TextStyle(
                    color: fontColor,
                    fontSize: textTheme.bodyLarge?.fontSize,
                    fontWeight: textTheme.bodyLarge?.fontWeight,
                  ),
                  textAlign: TextAlign.justify,
                ),
                Expanded(
                  child: Text(
                    point,
                    style: textTheme.bodyLarge?.copyWith(color: fontColor),
                    textAlign: TextAlign.justify,
                  ),
                ),
              ],
            )),
      ],
    );
  }
}
