// test/register_manager_test.dart
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/logic/register_manager.dart';
import 'package:flutter_testing_lab/models/register_form_model.dart';

void main() {
  group('RegisterManager', () {
    late RegisterManager manager;
    late RegisterFormModel model;

    setUp(() {
      manager = RegisterManager();
      model = RegisterFormModel();
    });

    test('Valid email passes regex', () {
      expect(manager.isValidEmail('test@example.com'), isTrue);
      expect(manager.isValidEmail('a@b.co'), isTrue);
    });

    test('Invalid email fails regex', () {
      expect(manager.isValidEmail('a@'), isFalse);
      expect(manager.isValidEmail('@b.com'), isFalse);
      expect(manager.isValidEmail('plainaddress'), isFalse);
    });

    test('Valid password passes strength check', () {
      expect(manager.isValidPassword('Passw0rd!'), isTrue);
      expect(manager.isValidPassword('Abc123@a'), isTrue);
    });

    test('Invalid password fails strength check', () {
      expect(manager.isValidPassword('short'), isFalse);
      expect(manager.isValidPassword('password123'), isFalse);
      expect(manager.isValidPassword('Password!'), isFalse);
    });

    test('Form validation sets errors correctly for empty fields', () {
      final valid = manager.validateForm(model);
      expect(valid, isFalse);
      expect(model.nameError, isNotNull);
      expect(model.emailError, isNotNull);
      expect(model.passwordError, isNotNull);
      expect(model.confirmPasswordError, isNotNull);
    });

    test('Form validation passes for correct input', () {
      model.name = 'Ahmed';
      model.email = 'ahmed@test.com';
      model.password = 'Strong1!';
      model.confirmPassword = 'Strong1!';

      final valid = manager.validateForm(model);
      expect(valid, isTrue);
      expect(model.nameError, isNull);
      expect(model.emailError, isNull);
      expect(model.passwordError, isNull);
      expect(model.confirmPasswordError, isNull);
    });

    test('Form validation detects password mismatch', () {
      model.name = 'Ahmed';
      model.email = 'ahmed@test.com';
      model.password = 'Strong1!';
      model.confirmPassword = 'Mismatch1!';

      final valid = manager.validateForm(model);
      expect(valid, isFalse);
      expect(model.confirmPasswordError, 'Passwords do not match');
    });
  });
}
