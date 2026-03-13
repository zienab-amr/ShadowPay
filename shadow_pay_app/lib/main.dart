import 'package:flutter/material.dart';
import 'splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Register/register_screen.dart';
import 'Onboard/onboarding_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

       locale: Locale('en'),
      supportedLocales: [
    Locale('en'),
    Locale('ar'),
  ],
  localizationsDelegates: [
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
      title: 'ShadowPay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}