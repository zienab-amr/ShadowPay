import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shadow_pay_app/Onboard/home_screen.dart';
import '../constants/colors.dart';
//import '../onboard/login_screen.dart'; 
class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {

  final passwordController = TextEditingController();
  final confirmController = TextEditingController();

  bool showPassword = false;
  bool showConfirm = false;

   void resetPassword() 
   {
    if (passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Password cannot be empty")),
      );
      return;
    }

    if (passwordController.text != confirmController.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Passwords do not match")),
      );
      return;
    }
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Password Reset Successfully"),
        backgroundColor: Colors.teal,
      ),
    );

    Navigator.pushAndRemoveUntil(
      context,
       //login bdl home
      MaterialPageRoute(builder: (context) => const HomeScreen()),
      (route) => false, 
    );
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

              children: [

                const Icon(
                  Icons.lock_reset,
                  color: Colors.white,
                  size: 70,
                ),

                const SizedBox(height: 25),

                const Text(
                  "Reset Password",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 30),

                GlassCard(

                  child: Column(

                    children: [

                      buildField(
                        controller: passwordController,
                        hint: "New Password",
                        icon: Icons.lock,
                        obscure: !showPassword,
                        suffix: IconButton(
                          icon: Icon(
                            showPassword
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white70,
                          ),
                          onPressed: () {
                            setState(() {
                              showPassword = !showPassword;
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 15),

                      buildField(
                        controller: confirmController,
                        hint: "Confirm Password",
                        icon: Icons.lock,
                        obscure: !showConfirm,
                        suffix: IconButton(
                          icon: Icon(
                            showConfirm
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.white70,
                          ),
                          onPressed: () {
                            setState(() {
                              showConfirm = !showConfirm;
                            });
                          },
                        ),
                      ),

                      const SizedBox(height: 25),

                      SizedBox(
                        width: double.infinity,
                        height: 55,

                        child: ElevatedButton(

                          onPressed: resetPassword,

                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.mediumBlueColor,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                          ),

                          child: const Text(
                            "Reset Password",
                            style: TextStyle(fontSize: 18),
                          ),

                        ),

                      )

                    ],

                  ),

                )

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
    bool obscure = false,
    Widget? suffix,
  }) {

    return TextField(

      controller: controller,
      obscureText: obscure,

      style: const TextStyle(
        color: Colors.white,
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

        suffixIcon: suffix,

        filled: true,

        fillColor: Colors.black26,

        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16),
          borderSide: BorderSide.none,
        ),

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

        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),

        child: Container(

          padding: const EdgeInsets.all(24),

          decoration: BoxDecoration(
            color: Colors.white.withOpacity(.05),
            borderRadius: BorderRadius.circular(28),
            border: Border.all(color: Colors.white10),
          ),

          child: child,

        ),

      ),

    );

  }

}