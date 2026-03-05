import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'Onboard/onboard_screen.dart';
=======
import 'screens/onboarding_screen.dart'; // عدلي المسار حسب اسم الملف عندك
>>>>>>> 1bd94fd2bbb3bd8cf36691500ee2ff63f696d827

void main() {
  
  runApp(const MyApp());
  
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
<<<<<<< HEAD
    return MaterialApp(
      title: 'ShadowPay',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: Scaffold(
        backgroundColor: Colors.white,
        body: OnboardScreen(),
      ),
    );
  }
}
=======
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: OnboardingScreen(),
    );
  }
}
>>>>>>> 1bd94fd2bbb3bd8cf36691500ee2ff63f696d827
