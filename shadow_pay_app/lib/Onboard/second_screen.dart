import 'package:flutter/material.dart';

class SecondScreen extends StatelessWidget {
  const SecondScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            const SizedBox(height: 20),

            Center(
              child: Container(
                width: 260,
                height: 300,
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: const Color(0xFF1E293B),
                  borderRadius: BorderRadius.circular(40),
                  border: Border.all(color: Colors.white12, width: 4),
                ),
                child: Column(
                  children: [

                    /// earpiece
                    Container(
                      width: 60,
                      height: 4,
                      margin: const EdgeInsets.only(bottom: 20),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),

                    /// alert card
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: const Color(0xFF0F172A),
                        borderRadius: BorderRadius.circular(16),
                        border: const Border(
                          left: BorderSide(
                            color: Colors.red,
                            width: 4,
                          ),
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [

                          Row(
                            children: const [
                              Icon(Icons.warning, color: Colors.red, size: 18),
                              SizedBox(width: 6),
                              Text(
                                "SECURITY ALERT",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 8),

                          const Text(
                            "Unusual Activity Detected",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 6),

                          const Text(
                            "Attempted \$540.00 at Global Tech Store",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),

                          const SizedBox(height: 12),

                          Row(
                            children: [

                              Expanded(
                                child: Container(
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 1, 116, 105),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text(
                                    "Review",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),

                              const SizedBox(width: 8),

                              Expanded(
                                child: Container(
                                  height: 30,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: Colors.grey,
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: const Text(
                                    "Ignore",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 35),

            /// Title
            const Text(
              "Real-time Fraud Alerts",
              style: TextStyle(
                fontSize: 28,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 15),

            /// Description
            const Text(
              "Our AI-driven engine monitors your account 24/7 to keep your digital assets secure and your mind at peace.",
              style: TextStyle(
                color: Colors.white70,
                fontSize: 16,
                height: 1.6,
              ),
            ),

            const SizedBox(height: 25),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: HSLColor.fromColor(const Color(0xFF00BBA7)).withLightness(0.4).toColor(),
                  width: 2,
                ), 
                ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFF00BBA7).withOpacity(0.1), 
                    child: Icon(Icons.ac_unit, color: const Color(0xFF00BBA7),),
                  ),
                  SizedBox(width: 25),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Instant Card Freezing",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Automatically block your card the second a suspicious transaction is flagged.",
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 20),

            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF0F172A),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: HSLColor.fromColor(const Color(0xFF00BBA7)).withLightness(0.4).toColor(),
                  width: 2,
                ), 
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Color(0xFF00BBA7).withOpacity(0.1), 
                    child: Icon(Icons.query_stats, color: const Color(0xFF00BBA7),),
                  ),
                  SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Dynamic Risk Scores",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Every transaction is graded in real-time based on your unique spending profile.",
                          style: TextStyle(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),

            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}