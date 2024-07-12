import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:authentication_api/firebase_options.dart';
import 'package:authentication_api/provider/cal_provider.dart';
import 'package:authentication_api/provider/theme_provider.dart';
import 'package:authentication_api/views/auth_page.dart';
import 'package:authentication_api/services/connectivity_service.dart';
import 'package:authentication_api/services/battery_service.dart';

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
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _connectivityService.initConnectivity(context);
      _batteryService.initBatteryMonitor(context);
    });
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
            title: 'Authentication',
            theme: themeProvider.isDarkMode ? ThemeData.dark() : ThemeData.light(),
            home: const AuthPage(),
          );
        },
      ),
    );
  }
}
