import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'otp_screen.dart';
//import '../onboard/login_screen.dart'; 
import '../Onboard/home_screen.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {

  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return "Invalid email";
    }

    return null;
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

void sendCode() {

  if (formKey.currentState!.validate()) {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const OtpScreen(),
      ),
    );

  }

}

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Container(

        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xff0a1628),
              Color(0xff0f1f3a),
              Color(0xff0a1628)
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(

          child: SingleChildScrollView(

            padding: const EdgeInsets.all(24),

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                const LogoWidget(),

                const SizedBox(height: 30),

                const Text(
                  "Forgot Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Enter your email to receive a reset code",
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                  textAlign: TextAlign.center,
                ),

                const SizedBox(height: 30),

                GlassCard(

                  child: Form(

                    key: formKey,

                    child: Column(

                      children: [

                        buildField(
                          controller: emailController,
                          hint: "Email Address",
                          icon: Icons.email,
                          validator: validateEmail,
                          keyboardType: TextInputType.emailAddress,
                        ),

                        const SizedBox(height: 25),

                        SizedBox(
                          width: double.infinity,
                          height: 55,

                          child: ElevatedButton(

                            onPressed: sendCode,

                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.mediumBlueColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16),
                              ),
                            ),

                            child: const Text(
                              "Send Code",
                              style: TextStyle(fontSize: 18),
                            ),

                          ),
                        ),

                        const SizedBox(height: 15),

                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacement(
                               context,
                              MaterialPageRoute(
                                //login bdl home
                                    builder: (context) => const HomeScreen(),
                              )
                                    );
                          },
                          child: const Text(
                            "Back to Login",
                            style: TextStyle(
                              color: Colors.white70,
                            ),
                          ),
                        )

                      ],

                    ),

                  ),

                ),

              ],

            ),

          ),

        ),

      ),

    );

  }

  Widget buildField({
    required TextEditingController controller,
    required String hint,
    required IconData icon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
  }) {

    return TextFormField(

      controller: controller,
      validator: validator,
      keyboardType: keyboardType,

      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
      ),

      decoration: InputDecoration(

        hintText: hint,

        hintStyle: const TextStyle(
          color: Colors.white54,
        ),

        prefixIcon: Icon(
          icon,
          color: Colors.white70,
        ),

        filled: true,

        fillColor: Colors.black26,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide(
            color: AppColors.mediumBlueColor,
            width: 1,
          ),
        ),

        contentPadding: const EdgeInsets.symmetric(vertical: 16),

      ),

    );

  }

}

class LogoWidget extends StatelessWidget {

  const LogoWidget({super.key});

  @override
  Widget build(BuildContext context) {

    return Container(

      width: 80,
      height: 80,

      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white10,
        boxShadow: const [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: Offset(0, 5),
          )
        ],
      ),

      child: const Icon(
        Icons.lock_reset,
        color: Colors.white,
        size: 40,
      ),

    );

  }

}

class GlassCard extends StatelessWidget {

  final Widget child;

  const GlassCard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {

    return ClipRRect(

      borderRadius: BorderRadius.circular(28),

      child: BackdropFilter(

        filter: ImageFilter.blur(
          sigmaX: 20,
          sigmaY: 20,
        ),

        child: Container(

          padding: const EdgeInsets.all(24),

          decoration: BoxDecoration(

            color: Colors.white.withOpacity(.05),

            borderRadius: BorderRadius.circular(28),

            border: Border.all(
              color: Colors.white10,
            ),

          ),

          child: child,

        ),

      ),

    );

  }

}