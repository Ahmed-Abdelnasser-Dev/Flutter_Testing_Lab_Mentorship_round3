class RegisterFormModel {
  String name;
  String email;
  String password;
  String confirmPassword;

  // Per-field error messages
  String? nameError;
  String? emailError;
  String? passwordError;
  String? confirmPasswordError;

  RegisterFormModel({
    this.name = '',
    this.email = '',
    this.password = '',
    this.confirmPassword = '',
    this.nameError,
    this.emailError,
    this.passwordError,
    this.confirmPasswordError,
  });

  // Reset all errors
  void clearErrors() {
    nameError = null;
    emailError = null;
    passwordError = null;
    confirmPasswordError = null;
  }
}
