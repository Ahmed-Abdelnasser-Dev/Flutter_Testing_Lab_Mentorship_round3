import 'package:flutter_testing_lab/models/register_form_model.dart';

class RegisterManager {
  // Validates email using regex
  bool isValidEmail(String email) {
    final emailRegex = RegExp(
      r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$",
    );
    return emailRegex.hasMatch(email);
  }

  // Validates password strength
  bool isValidPassword(String password) {
    if (password.length < 8) return false;

    final numberRegex = RegExp(r'\d'); // at least one number
    final symbolRegex = RegExp(
      r'[!@#\$%\^&\*\(\),\.\?":{}|<>]',
    ); // at least one special char

    return numberRegex.hasMatch(password) && symbolRegex.hasMatch(password);
  }

  // Validates fields and updates model errors
  bool validateForm(RegisterFormModel model) {
    model.clearErrors();
    bool hasError = false;

    if (model.name.isEmpty) {
      model.nameError = 'Please enter your full name';
      hasError = true;
    } else if (model.name.length < 2) {
      model.nameError = 'Name must be at least 2 characters';
      hasError = true;
    }

    if (model.email.isEmpty) {
      model.emailError = 'Please enter your email';
      hasError = true;
    } else if (!isValidEmail(model.email)) {
      model.emailError = 'Please enter a valid email';
      hasError = true;
    }

    if (model.password.isEmpty) {
      model.passwordError = 'Please enter a password';
      hasError = true;
    } else if (!isValidPassword(model.password)) {
      model.passwordError =
          'Password must be 8+ chars, include numbers & special symbols';
      hasError = true;
    }

    if (model.confirmPassword.isEmpty) {
      model.confirmPasswordError = 'Please confirm your password';
      hasError = true;
    } else if (model.confirmPassword != model.password) {
      model.confirmPasswordError = 'Passwords do not match';
      hasError = true;
    }

    return !hasError;
  }

  // Simulate form submission
  Future<String> submitForm(RegisterFormModel model) async {
    if (!validateForm(model)) {
      return 'Please fix errors before submitting';
    }

    // Simulate API call
    await Future.delayed(const Duration(seconds: 2));
    return 'Registration successful!';
  }
}
