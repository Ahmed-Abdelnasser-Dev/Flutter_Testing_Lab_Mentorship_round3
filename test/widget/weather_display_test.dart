import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/view/weather_display.dart';

void main() {
  Future<void> pumpWeatherDisplay(WidgetTester tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: Scaffold(body: WeatherDisplay())),
    );
    // Wait for initial loading
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();
  }

  testWidgets('Shows error for invalid city', (tester) async {
    await pumpWeatherDisplay(tester);

    // Open dropdown
    await tester.tap(find.byType(DropdownButton<String>));
    await tester.pumpAndSettle();

    // Select "Invalid City"
    await tester.tap(find.text('Invalid City').last);
    await tester.pump(const Duration(seconds: 2));
    await tester.pumpAndSettle();

    expect(find.textContaining('Failed to load weather data'), findsOneWidget);
  });

  testWidgets('Displays weather card for valid city', (tester) async {
    await pumpWeatherDisplay(tester);

    expect(find.byType(Card), findsOneWidget);
    expect(find.textContaining('°C'), findsOneWidget);
  });

  testWidgets('Toggle between Celsius and Fahrenheit', (tester) async {
    await pumpWeatherDisplay(tester);

    // Check Celsius is displayed
    expect(find.textContaining('°C'), findsOneWidget);

    // Switch to Fahrenheit
    await tester.tap(find.byType(Switch));
    await tester.pumpAndSettle();

    expect(find.textContaining('°F'), findsOneWidget);
  });
}
