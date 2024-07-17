import 'package:authentication_api/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:authentication_api/provider/cal_provider.dart';
import 'package:authentication_api/provider/theme_provider.dart';
import 'package:authentication_api/views/auth_page.dart';
import 'package:authentication_api/services/connectivity_service.dart';
import 'package:authentication_api/services/battery_service.dart';
import 'package:authentication_api/generated/l10n.dart'; // Import the generated localization class

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final ConnectivityService _connectivityService = ConnectivityService();
  final BatteryService _batteryService = BatteryService();

  @override
  void initState() {
    super.initState();
    _connectivityService.initialize(context);
    _batteryService.initialize();
  }

  @override
  void dispose() {
    _connectivityService.dispose();
    _batteryService.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => CalculatorProvider()),
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Working with APIs',
            theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: const AuthPage(),
            locale: const Locale('en'),
            supportedLocales: const [
              Locale('en', 'US'),
              Locale('es', 'ES'),
              // Add other supported locales here
            ],
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            localeResolutionCallback: (locale, supportedLocales) {
              for (var supportedLocale in supportedLocales) {
                if (supportedLocale.languageCode == locale?.languageCode &&
                    supportedLocale.countryCode == locale?.countryCode) {
                  return supportedLocale;
                }
              }
              return supportedLocales.first;
            },
          );
        },
      ),
    );
  }
}
