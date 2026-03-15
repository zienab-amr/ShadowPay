import 'package:flutter/material.dart';
import 'package:shadow_pay_app/l10n/app_localizations.dart';
import 'package:shadow_pay_app/widgets/language_dialog.dart';
import 'package:provider/provider.dart';
import 'package:shadow_pay_app/providers/language_provider.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _obscurePassword = true;
  bool _isLoading = false;
  
  // For field validation colors
  bool _emailValid = true;
  bool _passwordValid = true;
  
  // Animation controllers for logo
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isHovered = false;
  
  // For Sign Up hover
  bool _isSignUpHovered = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.25).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.elasticOut),
    );
  }

  // Realistic email validation
  bool isEmailValid(String email) {
    email = email.trim();
    if (email.isEmpty) return false;
    if (email.length < 5 || email.length > 50) return false;
    if (!RegExp(r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$").hasMatch(email)) return false;
    if (email.split('@').length != 2) return false; // multiple @
    if (["mailinator.com", "tempmail.com"].contains(email.split('@')[1])) return false; // optional disposable
    return true;
  }

  // Stronger password validation (length >= 6)
  bool isPasswordValid(String password) {
    if (password.isEmpty) return false;
    if (password.length < 6) return false;
    // Optional: add stronger checks (uppercase, number, special char)
    return true;
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;
    final isRTL = Localizations.localeOf(context).languageCode == 'ar';
    
    return Scaffold(
      backgroundColor: const Color(0xFF0D111F), // Dark background
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Language Button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Align(
                  alignment: Alignment.topRight,
                  child: Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: const Color(0xFF1F2A44),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.language, color: Color(0xFF00D8A2)),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => const LanguageDialog(),
                        );
                      },
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              
              // Logo outside container with shadow and hover effect
              MouseRegion(
                onEnter: (_) => _onHover(true),
                onExit: (_) => _onHover(false),
                child: AnimatedBuilder(
                  animation: _scaleAnimation,
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimation.value,
                      child: Container(
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0xFF00D8A2).withOpacity(0.4),
                              blurRadius: 25,
                              spreadRadius: 8,
                              offset: const Offset(0, 8),
                            ),
                          ],
                        ),
                        child: Image.asset(
                          "assets/icon/icon.png",
                          width: 100,
                          height: 100,
                          errorBuilder: (context, error, stackTrace) => Container(
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              color: const Color(0xFF1F2A44),
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: const Color(0xFF00D8A2).withOpacity(0.4),
                                  blurRadius: 25,
                                  spreadRadius: 8,
                                  offset: const Offset(0, 8),
                                ),
                              ],
                            ),
                            child: const Icon(
                              Icons.payment, 
                              size: 50, 
                              color: Color(0xFF00D8A2),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 24),
              
              // Login Container
              Container(
                padding: const EdgeInsets.all(24),
                margin: const EdgeInsets.symmetric(horizontal: 24),
                decoration: BoxDecoration(
                  color: const Color(0xFF141A2B), // Card background
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.3),
                      blurRadius: 15,
                      spreadRadius: 2,
                      offset: const Offset(0, 8),
                    ),
                  ],
                ),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Title
                      Text(
                        localizations.loginTitle,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // Subtitle
                      Text(
                        localizations.welcomeMessage,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.white70,
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Email Field Label
                      Align(
                        alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
                        child: Text(
                          localizations.emailLabel,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // Email Field
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: !_emailValid
                              ? [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.3),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: TextFormField(
                          controller: _emailController,
                          keyboardType: TextInputType.emailAddress,
                          textDirection: TextDirection.ltr,
                          style: const TextStyle(color: Colors.white),
                          onChanged: (value) {
                            if (!_emailValid) {
                              setState(() {
                                _emailValid = true;
                              });
                            }
                          },
                          decoration: InputDecoration(
                            hintText: 'example@gmail.com',
                            hintStyle: const TextStyle(color: Colors.white38),
                            filled: true,
                            fillColor: !_emailValid 
                                ? Colors.red.withOpacity(0.1)
                                : const Color(0xFF1F2A44),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: !_emailValid 
                                    ? Colors.red 
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: !_emailValid 
                                    ? Colors.red 
                                    : const Color(0xFF00D8A2),
                                width: 1.5,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.email, 
                              color: !_emailValid 
                                  ? Colors.red 
                                  : Colors.white70,
                            ),
                          ),
                        ),
                      ),
                      
                      // Error message for email
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: EdgeInsets.only(
                          top: !_emailValid ? 8 : 0,
                          left: isRTL ? 0 : 12,
                          right: isRTL ? 12 : 0,
                        ),
                        height: !_emailValid ? 30 : 0,
                        child: !_emailValid
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    size: 16,
                                    color: Colors.red.shade400,
                                  ),
                                  const SizedBox(width: 4),
                                  Flexible(
                                    child: Text(
                                      _emailController.text.isEmpty
                                          ? localizations.emailRequired
                                          : localizations.emailInvalid,
                                      style: TextStyle(
                                        color: Colors.red.shade400,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : null,
                      ),
                      
                      const SizedBox(height: 16),

                      // Password Field Label
                      Align(
                        alignment: isRTL ? Alignment.centerRight : Alignment.centerLeft,
                        child: Text(
                         localizations.passwordLabel,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      
                      // Password Field
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: !_passwordValid
                              ? [
                                  BoxShadow(
                                    color: Colors.red.withOpacity(0.3),
                                    blurRadius: 8,
                                    spreadRadius: 1,
                                    offset: const Offset(0, 2),
                                  ),
                                ]
                              : null,
                        ),
                        child: TextFormField(
                          controller: _passwordController,
                          obscureText: _obscurePassword,
                          textDirection: isRTL ? TextDirection.rtl : TextDirection.ltr,
                          style: const TextStyle(color: Colors.white),
                          onChanged: (value) {
                            if (!_passwordValid) {
                              setState(() {
                                _passwordValid = true;
                              });
                            }
                          },
                          decoration: InputDecoration(
                            hintText: '********',
                            hintStyle: const TextStyle(color: Colors.white38),
                            filled: true,
                            fillColor: !_passwordValid 
                                ? Colors.red.withOpacity(0.1)
                                : const Color(0xFF1F2A44),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide.none,
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: !_passwordValid 
                                    ? Colors.red 
                                    : Colors.transparent,
                                width: 1.5,
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: !_passwordValid 
                                    ? Colors.red 
                                    : const Color(0xFF00D8A2),
                                width: 1.5,
                              ),
                            ),
                            prefixIcon: Icon(
                              Icons.lock, 
                              color: !_passwordValid 
                                  ? Colors.red 
                                  : Colors.white70,
                            ),
                            suffixIcon: IconButton(
                              icon: Icon(
                                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                                color: !_passwordValid 
                                    ? Colors.red 
                                    : Colors.white70,
                              ),
                              onPressed: () {
                                setState(() {
                                  _obscurePassword = !_obscurePassword;
                                });
                              },
                            ),
                          ),
                        ),
                      ),
                      
                      // Error message for password
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: EdgeInsets.only(
                          top: !_passwordValid ? 8 : 0,
                          left: isRTL ? 0 : 12,
                          right: isRTL ? 12 : 0,
                        ),
                        height: !_passwordValid ? 30 : 0,
                        child: !_passwordValid
                            ? Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.error_outline,
                                    size: 16,
                                    color: Colors.red.shade400,
                                  ),
                                  const SizedBox(width: 4),
                                  Expanded(
                                    child: Text(
                                      _passwordController.text.isEmpty
                                          ? localizations.passwordRequired
                                          : localizations.passwordTooShort,
                                      style: TextStyle(
                                        color: Colors.red.shade400,
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            : null,
                      ),
                      
                      const SizedBox(height: 12),

                      // Forgot Password
                      Align(
                        alignment: isRTL ? Alignment.centerLeft : Alignment.centerRight,
                        child: TextButton(
                          onPressed: () {
                            // Navigate to forgot password
                          },
                          child: Text(
                            localizations.forgotPassword,
                            style: const TextStyle(color: Color(0xFF00D8A2)),
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Login Button
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: _isLoading ? null : _handleLogin,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00D8A2),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: _isLoading
                              ? const CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  localizations.loginButton,
                                  style: const TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 16),

                      // Sign Up Link with hover and focus effects
                      MouseRegion(
                        onEnter: (_) => setState(() => _isSignUpHovered = true),
                        onExit: (_) => setState(() => _isSignUpHovered = false),
                        child: Focus(
                          onFocusChange: (hasFocus) {
                            setState(() {});
                          },
                          child: TextButton(
                            onPressed: () {
                              // Navigate to sign up
                            },
                            style: TextButton.styleFrom(
                              foregroundColor: _isSignUpHovered 
                                  ? Colors.white 
                                  : const Color(0xFF00D8A2),
                              overlayColor: const Color(0xFF00D8A2).withOpacity(0.1),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 20, 
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeInOut,
                              decoration: BoxDecoration(
                                border: _isSignUpHovered
                                    ? Border(
                                        bottom: BorderSide(
                                          color: const Color(0xFF00D8A2),
                                          width: 2,
                                        ),
                                      )
                                    : null,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  // Animated arrow with RTL support
                                  AnimatedContainer(
                                    duration: const Duration(milliseconds: 200),
                                    curve: Curves.easeInOut,
                                    transform: Matrix4.translationValues(
                                      _isSignUpHovered 
                                          ? (isRTL ? -5 : 5) 
                                          : 0, 
                                      0, 
                                      0
                                    ),
                                    child: Icon(
                                      isRTL ? Icons.arrow_back : Icons.arrow_forward,
                                      size: 18,
                                      color: _isSignUpHovered 
                                          ? Colors.white 
                                          : const Color(0xFF00D8A2),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                     localizations.noAccount,
                                    style: TextStyle(
                                      color: _isSignUpHovered 
                                          ? Colors.white 
                                          : Colors.white70,
                                      fontSize: 14,
                                    ),
                                  ),
                                  Text(
                                      localizations.signUp,
                                    style: TextStyle(
                                      color: _isSignUpHovered 
                                          ? Colors.white 
                                          : const Color(0xFF00D8A2),
                                      fontSize: 14,
                                      fontWeight: _isSignUpHovered 
                                          ? FontWeight.bold 
                                          : FontWeight.w600,
                                      decoration: _isSignUpHovered
                                          ? TextDecoration.underline
                                          : TextDecoration.none,
                                      decorationColor: const Color(0xFF00D8A2),
                                      decorationThickness: 2,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _onHover(bool isHovered) {
    setState(() {
      _isHovered = isHovered;
    });
    if (isHovered) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  void _handleLogin() {
    final localizations = AppLocalizations.of(context)!;
    
    setState(() {
      _emailValid = isEmailValid(_emailController.text);
      _passwordValid = isPasswordValid(_passwordController.text);
    });

    // If both are valid, proceed with login
    if (_emailValid && _passwordValid) {
      setState(() => _isLoading = true);

      // Simulate login process
      Future.delayed(const Duration(seconds: 2), () {
        setState(() => _isLoading = false);
        // Navigate to home screen
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
             content: Text(localizations.loginSuccess),
            backgroundColor: const Color(0xFF00D8A2),
          ),
        );
      });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _animationController.dispose();
    super.dispose();
  }
}