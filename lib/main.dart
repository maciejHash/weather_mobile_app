import 'package:flutter/material.dart';
import 'screens/home_screen.dart';
import 'package:provider/provider.dart';
import 'providers/weather_provider.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  await Hive.openBox('weatherBox');

  runApp(
    ChangeNotifierProvider(
      create: (_) => WeatherProvider(),
      child: const WeatherApp(),
    ),
  );
}

class WeatherApp extends StatelessWidget {
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Weather App',
      locale: const Locale('pl', 'PL'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pl', 'PL')],
      theme: ThemeData(
        useMaterial3: true,

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),

        appBarTheme: const AppBarTheme(centerTitle: true),
      ),
      home: const HomeScreen(),
    );
  }
}
