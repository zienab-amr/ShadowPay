import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:shadow_pay_app/l10n/app_localizations.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> with SingleTickerProviderStateMixin {
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

  // متغيرات لتتبع حالة الأخطاء في كل حقل
  final Map<String, bool> fieldErrors = {
    'fullName': false,
    'email': false,
    'password': false,
    'confirm': false,
    'phone': false,
    'cardName': false,
    'cardNumber': false,
    'expiry': false,
  };

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    
    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0.1, 0),
      end: Offset.zero,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeOutCubic,
    ));
    
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
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

  // في بداية الكود مع المتغيرات
  final List<String> stepOneFields = ['fullName', 'email', 'password', 'confirm'];
  final List<String> stepTwoFields = ['phone', 'cardName', 'cardNumber', 'expiry'];

  void _changeStep(int newStep) {
    if (newStep == currentStep) return;
    
    setState(() {
      // تحديد الحقول اللي هنخفيها حسب الخطوة الحالية
      final fieldsToHide = currentStep == 1 ? stepOneFields : stepTwoFields;
      
      // إخفاء أخطاء الحقول دي
      for (var field in fieldsToHide) {
        fieldErrors[field] = false;
      }
      
      // تغيير الخطوة
      currentStep = newStep;
    });
    
    // تشغيل الأنيميشن
    _animationController
      ..reset()
      ..forward();
  }

  // دوال التحقق - مع إضافة شرط التحقق من الصفحة الحالية
  String? _validateFullName(String? value) {
    // لو مش في الصفحة الأولى، ميعملش validation
    if (currentStep != 1) return null;
    
    final loc = AppLocalizations.of(context)!;
    
    if (value == null || value.isEmpty) {
     fieldErrors['fullName'] = true;
      return loc.requiredField;
    }
    
    // تقسيم النص باستخدام المسافة
    List<String> nameParts = value.trim().split(' ');
    
    // إزالة العناصر الفارغة (في حالة وجود مسافات متعددة)
    nameParts = nameParts.where((part) => part.isNotEmpty).toList();
    
    // التحقق من وجود جزأين على الأقل
    if (nameParts.length < 2) {
      fieldErrors['fullName'] = true;
      return loc.enterFirstAndLastName;
    }
    
    // التحقق من طول كل جزء
    for (String part in nameParts) {
      if (part.length < 3) {
       fieldErrors['fullName'] = true;
        return loc.eachNamePartMustBeAtLeast3Chars;
      }
    }
    
     fieldErrors['fullName'] = false;
    return null;
  }

  String? _validateEmail(String? value) {
    // لو مش في الصفحة الأولى، ميعملش validation
    if (currentStep != 1) return null;
    
    final loc = AppLocalizations.of(context)!;
    
    if (value == null || value.isEmpty) {
      fieldErrors['email'] = true;
      return loc.requiredField;
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      fieldErrors['email'] = true;
      return loc.invalidEmail;
    }
    
   fieldErrors['email'] = false;
    return null;
  }

  String? _validatePassword(String? value) {
    // لو مش في الصفحة الأولى، ميعملش validation
    if (currentStep != 1) return null;
    
    final loc = AppLocalizations.of(context)!;
    
    if (value == null || value.isEmpty) {
     fieldErrors['password'] = true;
      return loc.requiredField;
    }
    if (value.length < 8) {
       fieldErrors['password'] = true;
      return loc.passwordShort;
    }
    
   fieldErrors['password'] = false;
    return null;
  }

  String? _validateConfirm(String? value) {
    // لو مش في الصفحة الأولى، ميعملش validation
    if (currentStep != 1) return null;
    
    final loc = AppLocalizations.of(context)!;
    
    if (value == null || value.isEmpty) {
       fieldErrors['confirm'] = true;
      return loc.requiredField;
    }
    if (value != passwordController.text) {
      fieldErrors['confirm'] = true;
      return loc.passwordMismatch;
    }
    
     fieldErrors['confirm'] = false;
    return null;
  }

 String? _validatePhone(String? value) {
  // لو مش في الصفحة الثانية، ميعملش validation
  if (currentStep != 2) return null;
  
  final loc = AppLocalizations.of(context)!;
  
  if (value == null || value.trim().isEmpty) {
    setState(() => fieldErrors['phone'] = true);
    return loc.requiredField;
  }

  // تنظيف الرقم
  String cleanNumber = value.trim().replaceAll(RegExp(r'[\s\-\(\)\+]'), '');
  
  // التحقق من أن الرقم يحتوي على أرقام فقط بعد التنظيف
  if (!RegExp(r'^\d+$').hasMatch(cleanNumber)) {
    setState(() => fieldErrors['phone'] = true);
    return loc.phoneDigitsOnly;
  }

  // التحقق من طول الرقم (يدعم الأرقام المصرية والعالمية)
  if (cleanNumber.length < 9 || cleanNumber.length > 15) {
    setState(() => fieldErrors['phone'] = true);
    return loc.phoneInvalidLength;
  }

  // صيغ محددة للأرقام المصرية
  bool isValidEgyptianNumber = false;
  
  // لو الرقم مصري (بيبدأ بـ 01 أو 00201 أو +201)
  if (cleanNumber.startsWith('01') && cleanNumber.length == 11) {
    String secondDigit = cleanNumber[1];
    if (['0', '1', '2', '5'].contains(secondDigit)) {
      isValidEgyptianNumber = true;
    }
  }
  // لو الرقم مصري بمفتاح دولي
  else if (cleanNumber.startsWith('201') && cleanNumber.length == 12) {
    String thirdDigit = cleanNumber[2];
    if (['0', '1', '2', '5'].contains(thirdDigit)) {
      isValidEgyptianNumber = true;
    }
  }
  // لو الرقم مصري بكود 0020
  else if (cleanNumber.startsWith('00201') && cleanNumber.length == 14) {
    String fifthDigit = cleanNumber[4];
    if (['0', '1', '2', '5'].contains(fifthDigit)) {
      isValidEgyptianNumber = true;
    }
  }
  // أرقام عالمية (أي رقم طوله مناسب)
  else if (cleanNumber.length >= 10 && cleanNumber.length <= 15) {
    isValidEgyptianNumber = true;
  }

  if (!isValidEgyptianNumber) {
    setState(() => fieldErrors['phone'] = true);
    return loc.invalidPhone;
  }

  setState(() => fieldErrors['phone'] = false);
  return null;
}
  String? _validateCardName(String? value) {
    // لو مش في الصفحة الثانية، ميعملش validation
    if (currentStep != 2) return null;
    
    final loc = AppLocalizations.of(context)!;
    
    if (value == null || value.isEmpty) {
      fieldErrors['cardName'] = true;
      return loc.requiredField;
    }
    
    // تقسيم النص باستخدام المسافة
    List<String> nameParts = value.trim().split(' ');
    
    // إزالة العناصر الفارغة (في حالة وجود مسافات متعددة)
    nameParts = nameParts.where((part) => part.isNotEmpty).toList();
    
    // التحقق من وجود جزأين على الأقل
    if (nameParts.length < 2) {
    fieldErrors['cardName'] = true;
      return loc.enterFirstAndLastName;
    }
    
    // التحقق من طول كل جزء
    for (String part in nameParts) {
      if (part.length < 3) {
       fieldErrors['cardName'] = true;
        return loc.eachNamePartMustBeAtLeast3Chars;
      }
    }
    
     fieldErrors['cardName'] = false;
    return null;
  }
  
  String? _validateCardNumber(String? value) {
    // لو مش في الصفحة الثانية، ميعملش validation
    if (currentStep != 2) return null;
    
    final loc = AppLocalizations.of(context)!;
    
    if (value == null || value.isEmpty) {
     fieldErrors['cardNumber'] = true;
      return loc.requiredField;
    }
    final cleanNumber = value.replaceAll(' ', '');
    if (!RegExp(r'^\d{16}$').hasMatch(cleanNumber)) {
     fieldErrors['cardNumber'] = true;
      return loc.invalidCard;
    }
    
    fieldErrors['cardNumber'] = false;
    return null;
  }

  String? _validateExpiry(String? value) {
    // لو مش في الصفحة الثانية، ميعملش validation
    if (currentStep != 2) return null;
    
    final loc = AppLocalizations.of(context)!;
    
    if (value == null || value.isEmpty) {
     fieldErrors['expiry'] = true;
      return loc.requiredField;
    }
    if (!RegExp(r'^\d{2}/\d{2}$').hasMatch(value)) {
     fieldErrors['expiry'] = true;
      return loc.invalidExpiry;
    }
    
    final parts = value.split('/');
    final month = int.tryParse(parts[0]) ?? 0;
    final year = int.tryParse(parts[1]) ?? 0;
    
    final now = DateTime.now();
    final currentYear = now.year % 100;
    final currentMonth = now.month;

    if (month < 1 || month > 12) {
     fieldErrors['expiry'] = true;
      return loc.invalidMonth;
    }
    
    if (year < currentYear || (year == currentYear && month < currentMonth)) {
     fieldErrors['expiry'] = true;
      return loc.cardExpired;
    }
    
   fieldErrors['expiry'] = false;
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
  final isValid = formKey.currentState!.validate();
  
  setState(() {}); // تحديث الواجهة بعد ما validators تخلص
  
  if (isValid) {
    if (currentStep == 1) {
      _changeStep(2);
    } else {
      submit();
    }
  }
 
}
void prevStep() {
  if (currentStep == 2) {

    formKey.currentState?.reset(); // يمسح errors فقط

    setState(() {
      for (var field in stepTwoFields) {
        fieldErrors[field] = false;
      }

      currentStep = 1;
    });

    _animationController
      ..reset()
      ..forward();
  }
}
  void submit() async {
    final loc = AppLocalizations.of(context)!;
    
    setState(() => loading = true);
    
    // محاكاة طلب API
    await Future.delayed(const Duration(seconds: 2));
    
    if (mounted) {
      setState(() => loading = false);
      
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(loc.accountCreated),
          backgroundColor: Colors.teal,
          behavior: SnackBarBehavior.floating,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      );
      
      // طباعة البيانات للتأكد
      print('===== بيانات التسجيل =====');
      print('${loc.fullName}: ${fullNameController.text}');
      print('${loc.email}: ${emailController.text}');
      print('${loc.phone}: ${phoneController.text}');
      print('${loc.cardNumber}: ${cardNumberController.text}');
      print('=========================');
    }
  }

  void navigateToLogin() {
    Navigator.pushReplacementNamed(context, '/login');
  }

  // دالة لتحديد لون النص والايقونة
  Color _getLabelColor(String fieldName) {
    return fieldErrors[fieldName] == true ? Colors.red : Colors.white70;
  }

  @override
  Widget build(BuildContext context) {
    final loc = AppLocalizations.of(context)!;
    
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
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
                // Logo with enhanced shadow (في مكانه الأصلي)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.3),
                        blurRadius: 25,
                        spreadRadius: 2,
                        offset: const Offset(0, 10),
                      ),
                      BoxShadow(
                        color: Colors.black.withOpacity(0.2),
                        blurRadius: 15,
                        spreadRadius: 1,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: const LogoWidget(),
                ),
                const SizedBox(height: 30),
                
                // Step Progress with animation
                TweenAnimationBuilder<double>(
                  tween: Tween(begin: 0.0, end: 1.0),
                  duration: const Duration(milliseconds: 400),
                  curve: Curves.easeOutBack,
                  builder: (context, value, child) {
                    return Transform.scale(
                      scale: value,
                      child: child,
                    );
                  },
                  child: StepProgress(currentStep: currentStep),
                ),
                
                const SizedBox(height: 10),
                
                // Step text with fade animation
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (Widget child, Animation<double> animation) {
                    return FadeTransition(
                      opacity: animation,
                      child: SlideTransition(
                        position: Tween<Offset>(
                          begin: const Offset(0, 0.2),
                          end: Offset.zero,
                        ).animate(CurvedAnimation(
                          parent: animation,
                          curve: Curves.easeOut,
                        )),
                        child: child,
                      ),
                    );
                  },
                  child: Text(
                    currentStep == 1 ? loc.step : loc.stepTwo,
                    key: ValueKey<int>(currentStep),
                    style: const TextStyle(color: Colors.white70, fontSize: 16),
                  ),
                ),
                
                const SizedBox(height: 30),

                // Credit Card Preview with animation and enhanced shadow
                if (currentStep == 2)
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 500),
                    transitionBuilder: (Widget child, Animation<double> animation) {
                      return FadeTransition(
                        opacity: animation,
                        child: ScaleTransition(
                          scale: Tween<double>(begin: 0.8, end: 1.0).animate(
                            CurvedAnimation(
                              parent: animation,
                              curve: Curves.easeOutBack,
                            ),
                          ),
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      key: const ValueKey<int>(2),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(25),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.teal.withOpacity(0.4),
                            blurRadius: 30,
                            spreadRadius: 5,
                            offset: const Offset(0, 15),
                          ),
                          BoxShadow(
                            color: Colors.black.withOpacity(0.3),
                            blurRadius: 20,
                            spreadRadius: 2,
                            offset: const Offset(0, 8),
                          ),
                        ],
                      ),
                      child: CreditCardPreview(
                        cardNameController: cardNameController,
                        cardNumberController: cardNumberController,
                        expiryController: expiryController,
                        loc: loc,
                        hasError: fieldErrors['cardNumber'] == true || 
                                 fieldErrors['expiry'] == true || 
                                 fieldErrors['cardName'] == true,
                      ),
                    ),
                  ),

                if (currentStep == 2) const SizedBox(height: 30),

                // Glass Card with enhanced shadow
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(28),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.5),
                        blurRadius: 30,
                        spreadRadius: 5,
                        offset: const Offset(0, 15),
                      ),
                      BoxShadow(
                        color: Colors.teal.withOpacity(0.1),
                        blurRadius: 20,
                        spreadRadius: 2,
                        offset: const Offset(0, 5),
                      ),
                    ],
                  ),
                  child: GlassCard(
                    child: Form(
                      key: formKey,
                      child: Column(
                        children: [
                          // عنوان حسب الخطوة مع animation
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 300),
                            transitionBuilder: (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: SlideTransition(
                                  position: Tween<Offset>(
                                    begin: const Offset(0, 0.1),
                                    end: Offset.zero,
                                  ).animate(CurvedAnimation(
                                    parent: animation,
                                    curve: Curves.easeOut,
                                  )),
                                  child: child,
                                ),
                              );
                            },
                            child: Text(
                              currentStep == 1 ? loc.register : loc.paymentInfo,
                              key: ValueKey<String>(currentStep == 1 ? 'register' : 'payment'),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // حقول مع SlideTransition
                          FadeTransition(
                            opacity: _fadeAnimation,
                            child: SlideTransition(
                              position: _slideAnimation,
                              child: Column(
                                children: [
                                  if (currentStep == 1) ...[
                                    // حقل الاسم الكامل
                                    Container(
                                      decoration: BoxDecoration(
                                        color: fieldErrors['fullName'] == true ? Colors.red.withOpacity(0.1) : Colors.transparent,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: buildField(
                                        controller: fullNameController,
                                        hint: loc.fullName,
                                        icon: Icons.person,
                                        validator: _validateFullName,
                                        labelColor: _getLabelColor('fullName'),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    
                                    // حقل البريد الإلكتروني
                                    Container(
                                      decoration: BoxDecoration(
                                        color: fieldErrors['email'] == true ? Colors.red.withOpacity(0.1) : Colors.transparent,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: buildField(
                                        controller: emailController,
                                        hint: loc.email,
                                        icon: Icons.email,
                                        validator: _validateEmail,
                                        keyboardType: TextInputType.emailAddress,
                                        labelColor: _getLabelColor('email'),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    
                                    // حقل كلمة المرور
                                    Container(
                                      decoration: BoxDecoration(
                                        color: fieldErrors['password'] == true ? Colors.red.withOpacity(0.1) : Colors.transparent,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: buildField(
                                        controller: passwordController,
                                        hint: loc.password,
                                        icon: Icons.lock,
                                        obscure: !showPassword,
                                        validator: _validatePassword,
                                        labelColor: _getLabelColor('password'),
                                        suffix: IconButton(
                                          icon: Icon(
                                            showPassword
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: fieldErrors['password'] == true 
                                                ? Colors.red 
                                                : Colors.white70,
                                          ),
                                          onPressed: () => setState(() => showPassword = !showPassword),
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    
                                    // حقل تأكيد كلمة المرور
                                    Container(
                                      decoration: BoxDecoration(
                                        color: fieldErrors['confirm'] == true ? Colors.red.withOpacity(0.1) : Colors.transparent,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: buildField(
                                        controller: confirmController,
                                        hint: loc.confirmPassword,
                                        icon: Icons.lock,
                                        obscure: !showConfirm,
                                        validator: _validateConfirm,
                                        labelColor: _getLabelColor('confirm'),
                                        suffix: IconButton(
                                          icon: Icon(
                                            showConfirm
                                                ? Icons.visibility_off
                                                : Icons.visibility,
                                            color: fieldErrors['confirm'] == true 
                                                ? Colors.red 
                                                : Colors.white70,
                                          ),
                                          onPressed: () => setState(() => showConfirm = !showConfirm),
                                        ),
                                      ),
                                    ),
                                  ],

                                  if (currentStep == 2) ...[
                                    // حقل الهاتف
                                    Container(
                                      decoration: BoxDecoration(
                                        color: fieldErrors['phone'] == true ? Colors.red.withOpacity(0.1) : Colors.transparent,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: buildField(
                                        controller: phoneController,
                                        hint: loc.phone,
                                        icon: Icons.phone,
                                        validator: _validatePhone,
                                        keyboardType: TextInputType.phone,
                                        labelColor: _getLabelColor('phone'),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    
                                    // حقل اسم حامل البطاقة
                                    Container(
                                      decoration: BoxDecoration(
                                        color: fieldErrors['cardName'] == true ? Colors.red.withOpacity(0.1) : Colors.transparent,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: buildField(
                                        controller: cardNameController,
                                        hint: loc.cardHolder,
                                        icon: Icons.person,
                                        validator: _validateCardName,
                                        onChanged: (_) => setState(() {}),
                                        labelColor: _getLabelColor('cardName'),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    
                                    // حقل رقم البطاقة
                                    Container(
                                      decoration: BoxDecoration(
                                        color: fieldErrors['cardNumber'] == true ? Colors.red.withOpacity(0.1) : Colors.transparent,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: buildField(
                                        controller: cardNumberController,
                                        hint: loc.cardNumber,
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
                                        labelColor: _getLabelColor('cardNumber'),
                                      ),
                                    ),
                                    const SizedBox(height: 15),
                                    
                                    // حقل تاريخ الانتهاء
                                    Container(
                                      decoration: BoxDecoration(
                                        color: fieldErrors['expiry'] == true ? Colors.red.withOpacity(0.1) : Colors.transparent,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: buildField(
                                        controller: expiryController,
                                        hint: "MM/YY",
                                        icon: Icons.calendar_month,
                                        validator: _validateExpiry,
                                        onChanged: (_) => setState(() {}),
                                        keyboardType: TextInputType.datetime,
                                        labelColor: _getLabelColor('expiry'),
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 25),

                          // الأزرار حسب الخطوة مع animation
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            transitionBuilder: (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: ScaleTransition(
                                  scale: Tween<double>(begin: 0.9, end: 1.0).animate(
                                    CurvedAnimation(
                                      parent: animation,
                                      curve: Curves.easeOut,
                                    ),
                                  ),
                                  child: child,
                                ),
                              );
                            },
                            child: currentStep == 1
                                ? SizedBox(
                                    key: const ValueKey<String>('next_button'),
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
                                        elevation: 8,
                                        shadowColor: Colors.teal.withOpacity(0.5),
                                      ),
                                      child: Text(
                                        loc.next,
                                        style: const TextStyle(fontSize: 18),
                                      ),
                                    ),
                                  )
                                : Row(
                                    key: const ValueKey<String>('finish_buttons'),
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
                                            elevation: 5,
                                            shadowColor: Colors.black.withOpacity(0.5),
                                          ),
                                          child: Text(
                                            loc.back,
                                            style: const TextStyle(fontSize: 16),
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
                                            elevation: 8,
                                            shadowColor: Colors.teal.withOpacity(0.5),
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
                                              : Text(
                                                  loc.finish,
                                                  style: const TextStyle(fontSize: 16),
                                                ),
                                        ),
                                      )
                                    ],
                                  ),
                          ),
                          
                          const SizedBox(height: 20),
                          
                          // Back to Login button (داخل الكونتينر)
                          InkWell(
                            onTap: navigateToLogin,
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white.withOpacity(0.1),
                                    Colors.white.withOpacity(0.05),
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                border: Border.all(
                                  color: Colors.white.withOpacity(0.2),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    loc.alreadyHaveAccount,
                                    style: TextStyle(
                                      color: Colors.white.withOpacity(0.7),
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  Text(
                                    loc.backToLogin,
                                    style: const TextStyle(
                                      color: Colors.teal,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(width: 5),
                                  const Icon(
                                    Icons.arrow_forward,
                                    color: Colors.teal,
                                    size: 16,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
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
    Color labelColor = Colors.white70,
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
        obscureText: obscure,
        validator: validator,
        onChanged: onChanged,
        keyboardType: keyboardType,
        maxLength: maxLength,
        style: const TextStyle(color: Colors.white, fontSize: 16),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(color: labelColor),
          prefixIcon: Icon(icon, color: labelColor),
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
          'assets/icon/icon.png',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
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
              boxShadow: [
                if (i <= currentStep)
                  BoxShadow(
                    color: Colors.teal.withOpacity(0.5),
                    blurRadius: 8,
                    spreadRadius: 1,
                  ),
              ],
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
  final AppLocalizations loc;
  final bool hasError;

  const CreditCardPreview({
    super.key,
    required this.cardNameController,
    required this.cardNumberController,
    required this.expiryController,
    required this.loc,
    this.hasError = false,
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
        gradient: hasError
            ? const LinearGradient(
                colors: [Color(0xffdc2626), Color(0xffb91c1c)],
              )
            : const LinearGradient(
                colors: [Color(0xff14b8a6), Color(0xff0ea5a4)],
              ),
        boxShadow: [
          BoxShadow(
            color: hasError 
                ? Colors.red.withOpacity(0.4)
                : Colors.teal.withOpacity(0.4),
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
                child: hasError
                    ? const Icon(Icons.error, color: Colors.white, size: 20)
                    : null,
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