import 'dart:ui';
import 'package:flutter/material.dart';
import '../constants/colors.dart';
import 'reset_password_screen.dart';

class OtpScreen extends StatefulWidget {
  const OtpScreen({super.key});

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {

  final List<TextEditingController> controllers =
      List.generate(6, (index) => TextEditingController());

bool get isOtpComplete {
    for (var controller in controllers) {
      if (controller.text.isEmpty) return false;
    }
    return true;
  }
  void verifyCode() {

    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const ResetPasswordScreen(),
      ),
    );

  }

  Widget otpBox(int index) {

    return SizedBox(
      width: 45,
      height: 55,

      child: TextField(

        controller: controllers[index],

        textAlign: TextAlign.center,

        maxLength: 1,

        keyboardType: TextInputType.number,

        style: const TextStyle(
          color: Colors.white,
          fontSize: 20,
        ),

        decoration: InputDecoration(

          counterText: "",

          filled: true,

          fillColor: Colors.black26,

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),

          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color: AppColors.mediumBlueColor,
            ),
          ),

        ),

        onChanged: (value) {
          setState(() {});
          
          if (value.isNotEmpty && index < 5) {
            FocusScope.of(context).nextFocus();
          }

        },

      ),

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

          child: Padding(

            padding: const EdgeInsets.all(24),

            child: Column(

              mainAxisAlignment: MainAxisAlignment.center,

              children: [

                const Icon(
                  Icons.verified_user,
                  color: Colors.white,
                  size: 70,
                ),

                const SizedBox(height: 20),

                const Text(
                  "Verify Code",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                const Text(
                  "Enter the 6 digit code sent to your email",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                  ),
                ),

                const SizedBox(height: 35),

                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(6, (index) => otpBox(index)),
                ),

                const SizedBox(height: 35),

                SizedBox(
                  width: double.infinity,
                  height: 55,

                  child: ElevatedButton(

                    onPressed: verifyCode,

                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.mediumBlueColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),

                    child: const Text(
                      "Verify",
                      style: TextStyle(fontSize: 18),
                    selectionColor: Colors.white),
                  ),

                ),

              ],

            ),

          ),

        ),

      ),

    );

  }

}