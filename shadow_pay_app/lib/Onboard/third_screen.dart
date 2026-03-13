import 'package:flutter/material.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            const SizedBox(height: 40),

            SizedBox(
              width: double.infinity,
              height: 250, 
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/thirdonboarding.png',
                    width: double.infinity,
                    height: 250,
                    fit: BoxFit.cover,
                    color: Colors.blue.withOpacity(0.5), 
                    colorBlendMode: BlendMode.modulate, 
                  ),
                  Container(
                    height: 120,
                    width: 120,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Color(0xFF1DBF73),
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 60,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            const Text(
              "Stay Protected",
              style: TextStyle(
                color: Colors.white,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 10),

            const Text(
              "Take full control of your card security with instant freezing capabilities and real-time monitoring.",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white70,
                fontSize: 15,
              ),
            ),

            const SizedBox(height: 30),

            // Feature Card 1
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: HSLColor.fromColor(const Color(0xFF00BBA7))
                      .withLightness(0.4)
                      .toColor(),
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFF00BBA7).withOpacity(0.1),
                    child: const Icon(
                      Icons.lock,
                      color: Color(0xFF00BBA7),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Manual Freeze",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Instantly lock your card yourself if you misplace it, anywhere in the world.",
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // Feature Card 2
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: HSLColor.fromColor(const Color(0xFF00BBA7))
                      .withLightness(0.4)
                      .toColor(),
                  width: 2,
                ),
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: const Color(0xFF00BBA7).withOpacity(0.1),
                    child: const Icon(
                      Icons.shield,
                      color: Color(0xFF00BBA7),
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Auto-Freeze",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Smart AI protection that freezes your card instantly upon suspicious activity detection.",
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }
}