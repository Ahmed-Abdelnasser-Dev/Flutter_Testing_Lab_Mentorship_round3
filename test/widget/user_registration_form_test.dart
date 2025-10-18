// test/user_registration_form_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/view/user_registration_form.dart';

void main() {
  testWidgets('Displays errors for empty form fields', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
    );

    // Tap register button
    final registerButton = find.text('Register');
    await tester.tap(registerButton);
    await tester.pumpAndSettle();

    // Check for error messages
    expect(find.text('Please enter your full name'), findsOneWidget);
    expect(find.text('Please enter your email'), findsOneWidget);
    expect(find.text('Please enter a password'), findsOneWidget);
    expect(find.text('Please confirm your password'), findsOneWidget);
  });

  testWidgets('Displays email validation error', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
    );

    await tester.enterText(find.byType(TextFormField).at(1), 'invalid-email');
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();

    expect(find.text('Please enter a valid email'), findsOneWidget);
  });

  testWidgets('Displays password strength error', (WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
    );

    await tester.enterText(find.byType(TextFormField).at(2), 'weakpass');
    await tester.tap(find.text('Register'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Password must be 8+ chars'), findsOneWidget);
  });

  testWidgets('Successful submission shows success SnackBar', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: UserRegistrationForm())),
    );

    await tester.enterText(find.byType(TextFormField).at(0), 'Ahmed');
    await tester.enterText(find.byType(TextFormField).at(1), 'ahmed@test.com');
    await tester.enterText(find.byType(TextFormField).at(2), 'Strong1!');
    await tester.enterText(find.byType(TextFormField).at(3), 'Strong1!');

    await tester.tap(find.text('Register'));
    await tester.pump(
      const Duration(seconds: 2),
    ); // wait for simulated API call
    await tester.pumpAndSettle();

    expect(find.text('Registration successful!'), findsOneWidget);
  });
}
