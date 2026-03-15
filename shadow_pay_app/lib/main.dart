import 'package:flutter/material.dart';
import 'package:provider/provider.dart'; 
import 'splash_screen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'Register/register_screen.dart';
import 'package:shadow_pay_app/login/login_screen.dart';
import 'Onboard/onboarding_screen.dart';
import 'package:shadow_pay_app/l10n/app_localizations.dart';
import 'package:shadow_pay_app/providers/language_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shadow_pay_app/home/home_screen.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => LanguageProvider(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  Future<Widget> _getFirstScreen() async {
    final prefs = await SharedPreferences.getInstance();
    bool seenOnboarding = prefs.getBool('seenOnboarding') ?? false;
    
    if (seenOnboarding) {
      return const LoginScreen();  
    } else {
      return const OnboardingScreen();  
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<LanguageProvider>(  
      builder: (context, languageProvider, child) {
        return MaterialApp(
          locale: languageProvider.locale,  
          supportedLocales: const [
            Locale('en'),
            Locale('ar'),
          ],
          localizationsDelegates: const [
            AppLocalizations.delegate,
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
          home: FutureBuilder<Widget>(
            future: _getFirstScreen(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const SplashScreen();
              }
              if (snapshot.hasError) {
                print('Error: ${snapshot.error}');
                return const LoginScreen();
              }
              return snapshot.data ?? const LoginScreen();
            },
          ),
        );
      },
    );
  }
}