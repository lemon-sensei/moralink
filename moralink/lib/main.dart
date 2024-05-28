// ---------- Common
import 'package:flutter/material.dart';

// ---------- Network
import 'package:firebase_core/firebase_core.dart';
import 'package:go_router/go_router.dart';
import 'package:moralink/config/firebase_config.dart';
import 'package:moralink/routes.dart';
import 'package:url_strategy/url_strategy.dart';

// ---------- Provider
import 'package:provider/provider.dart';
import 'package:moralink/providers/auth_provider.dart';
import 'package:moralink/providers/event_provider.dart';
import 'package:moralink/providers/language_provider.dart';
import 'package:moralink/providers/theme_provider.dart';
import 'package:moralink/providers/user_provider.dart';
import 'package:moralink/providers/qr_code_provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: FirebaseConfig.apiKey,
      authDomain: FirebaseConfig.authDomain,
      projectId: FirebaseConfig.projectId,
      storageBucket: FirebaseConfig.storageBucket,
      measurementId: FirebaseConfig.measurementId,
      appId: FirebaseConfig.appId,
      messagingSenderId: FirebaseConfig.messagingSenderId,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => EventProvider()),
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => QRCodeProvider()),
      ],
      child: const MoralinkApp(),
    ),
  );

  setPathUrlStrategy();
  GoRouter.optionURLReflectsImperativeAPIs = true;
}

class MoralinkApp extends StatelessWidget {
  const MoralinkApp({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final languageProvider = Provider.of<LanguageProvider>(context);

    return MaterialApp.router(
      routerConfig: router,
      title: 'Moralink',
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      themeMode: themeProvider.themeMode,
      locale: languageProvider.currentLocale,
      supportedLocales: const [
        Locale('en'),
        Locale('th'),
      ],
      debugShowCheckedModeBanner: false,
    );
  }
}
