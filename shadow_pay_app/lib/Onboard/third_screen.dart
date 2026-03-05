import 'package:flutter/material.dart';

class ThirdScreen extends StatelessWidget {
  const ThirdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF081B33),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [

              /// top bar
              Row(
                children: const [
                  Icon(Icons.arrow_back, color: Colors.white),
                  Spacer(),
                  Text(
                    "Security",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                ],
              ),

              const SizedBox(height: 40),

              /// check icon
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

              const SizedBox(height: 20),

              /// page indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  dot(false),
                  dot(false),
                  dot(true),
                ],
              ),

              const SizedBox(height: 40),

              /// title
              const Text(
                "Stay Protected",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              /// description
              const Text(
                "Take full control of your card security with instant freezing capabilities and real-time monitoring.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white70,
                  fontSize: 15,
                ),
              ),

              const SizedBox(height: 30),

              /// card 1
              featureCard(
                icon: Icons.ac_unit,
                title: "Manual Freeze",
                text:
                    "Instantly lock your card yourself if you misplace it, anywhere in the world.",
              ),

              const SizedBox(height: 20),

              /// card 2
              featureCard(
                icon: Icons.shield,
                title: "Auto-Freeze",
                text:
                    "Smart AI protection that freezes your card instantly upon suspicious activity detection.",
              ),

              const Spacer(),

              /// button
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2563EB),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(
                    "Get Started →",
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),

              const SizedBox(height: 10),

              const Text(
                "By continuing, you agree to ShadowPay's Security Terms & Conditions.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white54,
                  fontSize: 12,
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  /// dot indicator
  Widget dot(bool active) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      height: 8,
      width: 8,
      decoration: BoxDecoration(
        color: active ? Colors.blue : Colors.white24,
        shape: BoxShape.circle,
      ),
    );
  }

  /// feature card
  Widget featureCard({
    required IconData icon,
    required String title,
    required String text,
  }) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xFF0E2A4A),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Colors.blue.withOpacity(0.2),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, color: Colors.blue),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 5),
                Text(
                  text,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}