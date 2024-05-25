import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:moralink/config/firebase_config.dart';
import 'package:moralink/providers/auth_provider.dart';
import 'package:moralink/providers/event_provider.dart';
import 'package:moralink/providers/language_provider.dart';
import 'package:moralink/providers/theme_provider.dart';
import 'package:moralink/routes.dart';
import 'package:moralink/services/firebase_service.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: FirebaseConfig.apiKey,
      authDomain: FirebaseConfig.authDomain,
      projectId: FirebaseConfig.projectId,
      storageBucket: FirebaseConfig.storageBucket,
      messagingSenderId: FirebaseConfig.messagingSenderId,
      appId: FirebaseConfig.appId,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: const MoralinkApp(),
    ),
  );
}

class MoralinkApp extends StatelessWidget {
  const MoralinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp(
      title: 'Moralink',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      locale: languageProvider.currentLocale,
      supportedLocales: const [
        Locale('en'),
        Locale('th'),
      ],
      initialRoute: Routes.home,
      onGenerateRoute: Routes.generateRoute,
    );
  }
}