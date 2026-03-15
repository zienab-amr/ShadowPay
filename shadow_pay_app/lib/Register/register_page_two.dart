import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shadow_pay_app/l10n/app_localizations.dart';

class RegisterPageTwo extends StatefulWidget {
  final String fullName;
  final String email;
  final String password;

  const RegisterPageTwo({
    super.key,
    required this.fullName,
    required this.email,
    required this.password,
  });

  @override
  State<RegisterPageTwo> createState() => _RegisterPageTwoState();
}

class _RegisterPageTwoState extends State<RegisterPageTwo> {
  final formKey = GlobalKey<FormState>();

  final phoneController = TextEditingController();
  final cardNameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiryController = TextEditingController();

  bool loading = false;

  @override
  void dispose() {
    phoneController.dispose();
    cardNameController.dispose();
    cardNumberController.dispose();
    expiryController.dispose();
    super.dispose();
  }

  String formatCardNumber(String text) {
    text = text.replaceAll(" ", "");
    if (text.isEmpty) return "";
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i + 1) % 4 == 0 && i != text.length - 1) buffer.write(" ");
    }
    return buffer.toString();
  }

  void submit() async {
    final loc = AppLocalizations.of(context)!;

    if (formKey.currentState!.validate()) {
      setState(() => loading = true);

      await Future.delayed(const Duration(seconds: 2));

      if (mounted) {
        setState(() => loading = false);

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(loc.accountCreated),
            backgroundColor: Colors.teal,
          ),
        );

        Future.delayed(const Duration(seconds: 1), () {
          if (mounted) Navigator.popUntil(context, (route) => route.isFirst);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;

    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xff0a1628), Color(0xff0f1f3a), Color(0xff0a1628)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: Column(
              children: [
                const LogoWidget(),
                const SizedBox(height: 30),

                const StepProgress(currentStep: 2),
                const SizedBox(height: 10),

                Text(
                  loc.stepTwo,
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 30),

                CreditCardPreview(
                  cardNameController: cardNameController,
                  cardNumberController: cardNumberController,
                  expiryController: expiryController,
                ),
                const SizedBox(height: 30),

                GlassCard(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        buildField(
                          controller: phoneController,
                          hint: loc.phone,
                          icon: Icons.phone,
                        ),
                        const SizedBox(height: 15),

                        buildField(
                          controller: cardNameController,
                          hint: loc.cardHolder,
                          icon: Icons.person,
                          onChanged: (_) => setState(() {}),
                        ),
                        const SizedBox(height: 15),

                        buildField(
                          controller: cardNumberController,
                          hint: loc.cardNumber,
                          icon: Icons.credit_card,
                          keyboardType: TextInputType.number,
                          maxLength: 19,
                          onChanged: (value) {
                            final formatted = formatCardNumber(value);
                            cardNumberController.value = TextEditingValue(
                              text: formatted,
                              selection: TextSelection.collapsed(
                                offset: formatted.length,
                              ),
                            );
                            setState(() {});
                          },
                        ),
                        const SizedBox(height: 15),

                        buildField(
                          controller: expiryController,
                          hint: "MM/YY",
                          icon: Icons.calendar_month,
                          keyboardType: TextInputType.datetime,
                        ),
                        const SizedBox(height: 25),

                        Row(
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () => Navigator.pop(context),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.grey[800],
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(double.infinity, 55),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: Text(loc.back),
                              ),
                            ),
                            const SizedBox(width: 10),

                            Expanded(
                              child: ElevatedButton(
                                onPressed: loading ? null : submit,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.teal,
                                  foregroundColor: Colors.white,
                                  minimumSize: const Size(double.infinity, 55),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(16),
                                  ),
                                ),
                                child: loading
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          color: Colors.white,
                                          strokeWidth: 2,
                                        ),
                                      )
                                    : Text(loc.finish),
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
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
    Function(String)? onChanged,
    TextInputType? keyboardType,
    int? maxLength,
  }) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 8,
            spreadRadius: 1,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: TextFormField(
        controller: controller,
        onChanged: onChanged,
        keyboardType: keyboardType,
        maxLength: maxLength,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(color: Colors.white54),
          prefixIcon: Icon(icon, color: Colors.white70),
          filled: true,
          fillColor: Colors.black26,
          counterText: "",
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
            borderSide: const BorderSide(color: Colors.teal, width: 1),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: const BorderSide(color: Colors.redAccent, width: 1),
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
        ),
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
          ),
        ],
      ),
      child: const Icon(
        Icons.account_balance_wallet,
        color: Colors.white,
        size: 40,
      ),
    );
  }
}

class StepProgress extends StatelessWidget {
  final int currentStep;

  const StepProgress({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (int i = 1; i <= 2; i++)
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 5),
            width: 50,
            height: 6,
            decoration: BoxDecoration(
              color: i <= currentStep ? Colors.teal : Colors.white24,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
      ],
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

class CreditCardPreview extends StatelessWidget {
  final TextEditingController cardNameController;
  final TextEditingController cardNumberController;
  final TextEditingController expiryController;

  const CreditCardPreview({
    super.key,
    required this.cardNameController,
    required this.cardNumberController,
    required this.expiryController,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 180,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: const LinearGradient(
          colors: [Color(0xff14b8a6), Color(0xff0ea5a4)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.4),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Icon(Icons.credit_card, color: Colors.white, size: 35),
              Container(
                width: 50,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white24,
                  borderRadius: BorderRadius.circular(5),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(
            cardNumberController.text.isEmpty
                ? "1234 5678 9012 3456"
                : cardNumberController.text,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 22,
              letterSpacing: 2,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "CARD HOLDER",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    cardNameController.text.isEmpty
                        ? "YOUR NAME"
                        : cardNameController.text.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    "EXPIRES",
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      letterSpacing: 1,
                    ),
                  ),
                  Text(
                    expiryController.text.isEmpty ? "MM/YY" : expiryController.text,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}