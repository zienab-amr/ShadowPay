import 'package:flutter/material.dart';

class Onboardingone extends StatelessWidget {
  const Onboardingone({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF101622), // background-dark
      body: SafeArea(
        child: Column(
         
 children: [
            
          
            // Illustration Section
            Expanded(
              flex: 3,
              child: Center(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 320),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: AspectRatio(
                    aspectRatio: 1,
                    child: Stack(
                      children: [
                        // Decorative Glow
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF0d59f2).withOpacity(0.2),
                            shape: BoxShape.circle,
                          ),
                        ),

                        // Main Container
                        Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF1E293B).withOpacity(0.4),
                            borderRadius: BorderRadius.circular(24),
                            border: Border.all(
                              color: const Color(0xFF334155).withOpacity(0.5),
                            ),
                          ),
                          child: Stack(
                            clipBehavior: Clip.none,
                            children: [
                              // Background Fingerprint
                              Center(
                                child: Icon(
                                  Icons.fingerprint,
                                  size: 120,
                                  color: const Color(0xFF0d59f2).withOpacity(0.2),
                                ),
                              ),

                              // Floating Verified Card (Top Left)
                              Positioned(
                                top: 32,
                                left: 32,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1E293B),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: const Color(0xFF334155),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 20,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Container(
                                        width: 8,
                                        height: 8,
                                        decoration: const BoxDecoration(
                                          color: Color(0xFF10B981), // emerald
                                          shape: BoxShape.circle,
                                        ),
                                      ),
                                      const SizedBox(width: 8),
                                      const Text(
                                        'Verified',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Floating Risk Card (Bottom Right)
                              Positioned(
                                bottom: 48,
                                right: 24,
                                child: Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF1E293B),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: const Color(0xFF334155),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.black.withOpacity(0.3),
                                        blurRadius: 20,
                                        offset: const Offset(0, 8),
                                      ),
                                    ],
                                  ),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      const Text(
                                        'Analysis Risk',
                                        style: TextStyle(
                                          color: Color(0xFF64748B), // slate-500
                                          fontSize: 8,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      SizedBox(
                                        width: 96,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(12),
                                          child: const LinearProgressIndicator(
                                            value: 0.25,
                                            backgroundColor: Color(0xFF334155),
                                            valueColor:
                                                AlwaysStoppedAnimation<Color>(
                                              Color(0xFF0d59f2),
                                            ),
                                            minHeight: 6,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

                              // Central Lock Icon
                              Center(
                                child: Container(
                                  width: 96,
                                  height: 96,
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF0d59f2),
                                    borderRadius: BorderRadius.circular(16),
                                    boxShadow: [
                                      BoxShadow(
                                        color: const Color(0xFF0d59f2).withOpacity(0.4),
                                        blurRadius: 30,
                                        spreadRadius: 2,
                                      ),
                                    ],
                                  ),
                                  child: const Icon(
                                    Icons.lock_outline,
                                    color: Colors.white,
                                    size: 48,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),

            // Text Content
            const Expanded(
              flex: 2,
              child: Column(
                children: [
                  Text(
                    'Secure Your Transactions',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 16),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 48),
                    child: Text(
                      'Our advanced AI analyzes every transaction in real-time to protect your funds from fraud and unauthorized access.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Color(0xFF94A3B8), // slate-400
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ),
                  SizedBox(height: 32),

                  // Pagination Dots
                 
                ],
              ),
            ),

            // Action Button and Legal Text
           
                  
            
          ],
        ),
      ),
    );
  }
}
