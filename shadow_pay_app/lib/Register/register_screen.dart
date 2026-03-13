import 'dart:ui';
import 'package:flutter/material.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();

  // بيانات الصفحتين
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final phoneController = TextEditingController();
  final cardNameController = TextEditingController();
  final cardNumberController = TextEditingController();
  final expiryController = TextEditingController();

  bool showPassword = false;
  bool showConfirm = false;
  bool loading = false;

  int currentStep = 1; // 1 أو 2

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmController.dispose();
    phoneController.dispose();
    cardNameController.dispose();
    cardNumberController.dispose();
    expiryController.dispose();
    super.dispose();
  }

  // دوال التحقق
  String? _validateFullName(String? value) {
    if (value == null || value.isEmpty) return "هذا الحقل مطلوب";
    if (value.length < 3) return "الاسم يجب أن يكون 3 أحرف على الأقل";
    return null;
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) return "هذا الحقل مطلوب";
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return "البريد الإلكتروني غير صالح";
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) return "هذا الحقل مطلوب";
    if (value.length < 8) return "كلمة المرور يجب أن تكون 8 أحرف على الأقل";
    return null;
  }

  String? _validateConfirm(String? value) {
    if (value == null || value.isEmpty) return "هذا الحقل مطلوب";
    if (value != passwordController.text) return "كلمة المرور غير متطابقة";
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) return "هذا الحقل مطلوب";
    if (!RegExp(r'^\+?\d{10,15}$').hasMatch(value)) {
      return "رقم الهاتف غير صالح";
    }
    return null;
  }

  String? _validateCardNumber(String? value) {
    if (value == null || value.isEmpty) return "هذا الحقل مطلوب";
    final cleanNumber = value.replaceAll(' ', '');
    if (!RegExp(r'^\d{16}$').hasMatch(cleanNumber)) {
      return "رقم البطاقة غير صالح (16 رقم)";
    }
    return null;
  }

  String? _validateExpiry(String? value) {
    if (value == null || value.isEmpty) return "هذا الحقل مطلوب";
    if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
      return "الصيغة غير صالحة (MM/YY)";
    }
    return null;
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

  void nextStep() {
    if (formKey.currentState!.validate()) {
      if (currentStep == 1) {
        setState(() => currentStep = 2);
      } else {
        submit();
      }
    }
  }

  void prevStep() {
    if (currentStep == 2) {
      setState(() => currentStep = 1);
    }
  }

  void submit() async {
    setState(() => loading = true);
    
    // محاكاة طلب API
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() => loading = false);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("تم إنشاء الحساب بنجاح"),
          backgroundColor: Colors.teal,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      
      // طباعة البيانات للتأكد
      print('===== بيانات التسجيل =====');
      print('الاسم: ${fullNameController.text}');
      print('البريد: ${emailController.text}');
      print('الهاتف: ${phoneController.text}');
      print('البطاقة: ${cardNumberController.text}');
      print('=========================');
    }
  }

  @override
  Widget build(BuildContext context) {
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
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const LogoWidget(),
                const SizedBox(height: 30),
                StepProgress(currentStep: currentStep),
                const SizedBox(height: 10),
                Text(
                  "الخطوة $currentStep من 2",
                  style: const TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 30),

                // معاينة البطاقة في الخطوة 2
                if (currentStep == 2) ...[
                  CreditCardPreview(
                    cardNameController: cardNameController,
                    cardNumberController: cardNumberController,
                    expiryController: expiryController,
                  ),
                  const SizedBox(height: 30),
                ],

                GlassCard(
                  child: Form(
                    key: formKey,
                    child: Column(
                      children: [
                        // عنوان حسب الخطوة
                        Text(
                          currentStep == 1 ? "إنشاء حساب جديد" : "معلومات الدفع",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 20),

                        // حقول الخطوة الأولى
                        if (currentStep == 1) ...[
                          buildField(
                            controller: fullNameController,
                            hint: "الاسم الكامل",
                            icon: Icons.person,
                            validator: _validateFullName,
                          ),
                          const SizedBox(height: 15),
                          buildField(
                            controller: emailController,
                            hint: "البريد الإلكتروني",
                            icon: Icons.email,
                            validator: _validateEmail,
                            keyboardType: TextInputType.emailAddress,
                          ),
                          const SizedBox(height: 15),
                          buildField(
                            controller: passwordController,
                            hint: "كلمة المرور",
                            icon: Icons.lock,
                            obscure: !showPassword,
                            validator: _validatePassword,
                            suffix: IconButton(
                              icon: Icon(
                                showPassword
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white70,
                              ),
                              onPressed: () => setState(() => showPassword = !showPassword),
                            ),
                          ),
                          const SizedBox(height: 15),
                          buildField(
                            controller: confirmController,
                            hint: "تأكيد كلمة المرور",
                            icon: Icons.lock,
                            obscure: !showConfirm,
                            validator: _validateConfirm,
                            suffix: IconButton(
                              icon: Icon(
                                showConfirm
                                    ? Icons.visibility_off
                                    : Icons.visibility,
                                color: Colors.white70,
                              ),
                              onPressed: () => setState(() => showConfirm = !showConfirm),
                            ),
                          ),
                        ],

                        // حقول الخطوة الثانية
                        if (currentStep == 2) ...[
                          buildField(
                            controller: phoneController,
                            hint: "رقم الهاتف",
                            icon: Icons.phone,
                            validator: _validatePhone,
                            keyboardType: TextInputType.phone,
                          ),
                          const SizedBox(height: 15),
                          buildField(
                            controller: cardNameController,
                            hint: "اسم حامل البطاقة",
                            icon: Icons.person,
                            onChanged: (_) => setState(() {}),
                          ),
                          const SizedBox(height: 15),
                          buildField(
                            controller: cardNumberController,
                            hint: "رقم البطاقة",
                            icon: Icons.credit_card,
                            validator: _validateCardNumber,
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
                            keyboardType: TextInputType.number,
                            maxLength: 19,
                          ),
                          const SizedBox(height: 15),
                          buildField(
                            controller: expiryController,
                            hint: "MM/YY",
                            icon: Icons.calendar_month,
                            validator: _validateExpiry,
                            onChanged: (_) => setState(() {}),
                            keyboardType: TextInputType.datetime,
                          ),
                        ],

                        const SizedBox(height: 25),

                        // الأزرار حسب الخطوة
                        if (currentStep == 1)
                          SizedBox(
                            width: double.infinity,
                            height: 55,
                            child: ElevatedButton(
                              onPressed: nextStep,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.teal,
                                foregroundColor: Colors.white,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                elevation: 5,
                              ),
                              child: const Text(
                                "التالي",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ),

                        if (currentStep == 2)
                          Row(
                            children: [
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: prevStep,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.grey[800],
                                    foregroundColor: Colors.white,
                                    minimumSize: const Size(double.infinity, 55),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                  ),
                                  child: const Text(
                                    "رجوع",
                                    style: TextStyle(fontSize: 16),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: ElevatedButton(
                                  onPressed: loading ? null : nextStep,
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.teal,
                                    foregroundColor: Colors.white,
                                    minimumSize: const Size(double.infinity, 55),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    elevation: 5,
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
                                      : const Text(
                                          "إنهاء التسجيل",
                                          style: TextStyle(fontSize: 16),
                                        ),
                                ),
                              )
                            ],
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
    bool obscure = false,
    Widget? suffix,
    String? Function(String?)? validator,
    Function(String)? onChanged,
    TextInputType? keyboardType,
    int? maxLength,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: obscure,
      validator: validator,
      onChanged: onChanged,
      keyboardType: keyboardType,
      maxLength: maxLength,
      style: const TextStyle(color: Colors.white, fontSize: 16),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: Colors.white70),
        suffixIcon: suffix,
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
    );
  }
}

// الويدجت المشتركة
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
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Image.asset(
          'assets/icon/icon.png', // غير المسار حسب مكان صورتك
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            // في حالة خطأ في تحميل الصورة
            return Container(
              color: Colors.white10,
              child: const Icon(
                Icons.broken_image,
                color: Colors.white70,
                size: 40,
              ),
            );
          },
        ),
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

  String formatCardNumber(String text) {
    text = text.replaceAll(" ", "");
    if (text.isEmpty) return "1234 5678 9012 3456";
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i + 1) % 4 == 0 && i != text.length - 1) buffer.write(" ");
    }
    return buffer.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 200,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        gradient: const LinearGradient(
          colors: [Color(0xff14b8a6), Color(0xff0ea5a4)],
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.3),
            blurRadius: 15,
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
            formatCardNumber(cardNumberController.text),
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