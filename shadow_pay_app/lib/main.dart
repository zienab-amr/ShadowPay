import 'package:flutter/material.dart';
import 'screens/onboarding_screen.dart'; // استخدمي المسار الصحيح لملف onboarding واحد فقط

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShadowPay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OnboardingScreen(), // استخدمي اسم الشاشة المناسب هنا
    );
  }
}