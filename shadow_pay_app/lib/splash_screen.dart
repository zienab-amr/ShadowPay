import 'package:flutter/material.dart';
import 'Onboard/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;
  late Animation<double> _slideAnimation;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 4),
    );

    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.6, curve: Curves.easeIn),
      ),
    );

    _slideAnimation = Tween<double>(begin: 30.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
      ),
    );

    _scaleAnimation = Tween<double>(begin: 0.8, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.8, curve: Curves.elasticOut),
      ),
    );

    _controller.forward();

    // Navigation after 4 seconds
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                const OnboardingScreen(),
            transitionsBuilder:
                (context, animation, secondaryAnimation, child) {
              const begin = Offset(1.0, 0.0);
              const end = Offset.zero;
              const curve = Curves.easeInOutQuart;
              var tween =
                  Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
              var offsetAnimation = animation.drive(tween);
              return SlideTransition(
                position: offsetAnimation,
                child: child,
              );
            },
          ),
        );
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    
    const Color backgroundColor = Color(0xFF101622); 
    const Color surfaceColor = Color(0xFF1A1F2F); 
    const Color darkBlueColor = Color(0xFF00BBA7);   
    const Color mediumBlueColor = Color(0xFF00D1B8); 
    const Color lightBlueColor = Color(0xFF66E0D8);  
    const Color textWhite = Color(0xFFFFFFFF); 
    const Color textLightGray = Color(0xFFB0B8C5);
    const Color textGray = Color(0xFF8E98A8); 
    const Color statusGreen = Color(0xFF34A853); 
    const Color progressBackground = Color(0xFF2A2F3F); 

    return Scaffold(
      backgroundColor: backgroundColor,
      body: Container(
        width: size.width,
        height: size.height,
        decoration: const BoxDecoration(
          
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              backgroundColor,
              Color(0xFF0F1422),
              backgroundColor,
            ],
          ),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              
              const Spacer(flex: 2),

              
              ScaleTransition(
                scale: _scaleAnimation,
                child: Container(
                  width: 150,
                  height: 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: darkBlueColor.withOpacity(0.3),
                        blurRadius: 25,
                        spreadRadius: 2,
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 15,
                        spreadRadius: 0,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: Image.asset(
                      'assets/icon/icon.png',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Container(
                          decoration: const BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color(0xFF00BBA7),
                                Color(0xFF00BBA7),
                              ],
                            ),
                          ),
                          child: const Center(
                            child: Text(
                              'SP',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              // ShadowPay
              RichText(
                textAlign: TextAlign.center,
                text: const TextSpan(
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1,
                  ),
                  children: [
                    TextSpan(
                      text: 'Shadow',
                      style: TextStyle(color: Colors.white),
                    ),
                    TextSpan(
                      text: 'Pay',
                      style: TextStyle(color: Color(0xFF00BBA7)),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 2),

              // AI-Driven Fraud Protection
              FadeTransition(
                opacity: _fadeAnimation,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: surfaceColor.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: lightBlueColor.withOpacity(0.2),
                      width: 1,
                    ),
                  ),
                  child: const Text(
                    'AI-Driven Fraud Protection',
                    style: TextStyle(
                      fontSize: 15,
                      color: mediumBlueColor,
                      fontWeight: FontWeight.w500,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // Progress bar
              TweenAnimationBuilder<double>(
                duration: const Duration(seconds: 4),
                tween: Tween(begin: 0.0, end: 1.0),
                builder: (context, value, child) {
                  return SizedBox(
                    width: size.width * 0.6,
                    child: LinearProgressIndicator(
                      value: value,
                      backgroundColor: progressBackground,
                      valueColor: const AlwaysStoppedAnimation<Color>(
                        mediumBlueColor,
                      ),
                      minHeight: 4,
                    ),
                  );
                },
              ),

              
              const Spacer(flex: 1),

              // SETTINGS and ENCRYPTED BY SHADOW PAY SECURELY - تحت خالص
              const Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  // SETTINGS
                  Text(
                    'SETTINGS',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: textLightGray,
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 8),

                  // ENCRYPTED BY SHADOW PAY SECURELY 
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'ENCRYPTED BY ',
                        style: TextStyle(
                          fontSize: 11,
                          color: textGray,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        'SHADOW PAY ',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          color: textGray,
                        ),
                      ),
                      //(security icon)
                      Icon(
                        Icons.security,
                        color: statusGreen,
                        size: 14,
                      ),
                      SizedBox(width: 2),
                    ],
                  ),
                ],
              ),
              // Spacer
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}