// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get home => 'Home';
  String get full_name => 'Full Name';

  @override
  String get confirm_password => 'Confirm Password';

  @override
  String get next => 'Next';

  @override
  String get step => 'Step 1 of 2';

  @override
  String get freeze_card => 'Freeze Card';

  @override
  String get loginTitle => 'Login';

  @override
  String get welcomeMessage => 'Hello,Welcome!';

  @override
  String get emailLabel => 'Email';

  @override
  String get passwordLabel => 'Password';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get loginButton => 'Login';

  @override
  String get noAccount => 'Don\'t have an account?';

  @override
  String get signUp => 'Sign Up';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get emailInvalid => 'Please enter a valid email';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordTooShort => 'Password must be at least 6 characters';

  @override
  String get select_language => 'Select Language';

  @override
  String get arabic => 'Arabic';

  @override
  String get english => 'English';

  @override
  String get cancel => 'Cancel';

  @override
  String get loginSuccess => 'Login Successfully';
=======
  String get requiredField => 'This field is required';

  @override
  String get invalidEmail => 'Invalid email';

  @override
  String get passwordShort => 'Password must be at least 8 characters';

  @override
  String get passwordMismatch => 'Passwords do not match';

  @override
  String get invalidPhone => 'Invalid phone number';

  @override
  String get invalidCard => 'Invalid card number';

  @override
  String get invalidExpiry => 'Invalid expiry format';

  @override
  String get nameShort => 'Name must be at least 3 characters';

  @override
  String get fullName => 'Full name';

  @override
  String get confirmPassword => 'Confirm password';

  @override
  String get phone => 'Phone number linked whith your card';

  @override
  String get cardHolder => 'Card holder name';

  @override
  String get cardNumber => 'Card number';

  @override
  String get back => 'Back';

  @override
  String get finish => 'Finish';

  @override
  String get invalidMonth => 'Invalid month';

  @override
  String get accountCreated => 'Account created successfully';

  @override
  String get stepTwo => 'Step 2 of 2';

  @override
  String get paymentInfo => 'Payment Information';

  @override
  String get enterFirstAndLastName => 'Please enter first and last name separated by a space';

  @override
  String get eachNamePartMustBeAtLeast3Chars => 'Each part of the name must be at least 3 characters';

  @override
  String get pleaseEnterExactlyTwoNames => 'Please enter exactly two names (first name and last name)';

  @override
  String get backToLogin => 'Back to Login';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get cardExpired => 'your card has been expired';

  @override
  String get cardNameTooShort => 'Card holder name must be at least 3 characters';

  @override
  String get cardNameInvalid => 'Card holder name must contain only letters';

  @override
  String get phoneDigitsOnly => 'Phone number must contain only digits';

  @override
  String get phoneInvalidLength => 'Invalid phone number (incorrect length)';
}
