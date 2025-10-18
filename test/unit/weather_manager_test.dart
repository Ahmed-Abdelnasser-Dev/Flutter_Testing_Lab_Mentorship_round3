import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_testing_lab/logic/weather_manager.dart';

void main() {
  late WeatherManager manager;

  setUp(() {
    manager = WeatherManager();
  });

  group('Temperature Conversion', () {
    test('Celsius to Fahrenheit', () {
      expect(manager.celsiusToFahrenheit(0), 32);
      expect(manager.celsiusToFahrenheit(100), 212);
      expect(manager.celsiusToFahrenheit(-40), -40);
    });

    test('Fahrenheit to Celsius', () {
      expect(manager.fahrenheitToCelsius(32), 0);
      expect(manager.fahrenheitToCelsius(212), 100);
      expect(manager.fahrenheitToCelsius(-40), -40);
    });
  });

  group('Weather Data Parsing', () {
    test('Parse valid data', () {
      final data = {
        'city': 'Test City',
        'temperature': 25,
        'description': 'Sunny',
        'humidity': 50,
        'windSpeed': 5.0,
        'icon': '☀️',
      };
      final weather = manager.parseWeatherData(data);
      expect(weather, isNotNull);
      expect(weather!.city, 'Test City');
      expect(weather.temperatureCelsius, 25);
      expect(weather.description, 'Sunny');
      expect(weather.humidity, 50);
      expect(weather.windSpeed, 5.0);
      expect(weather.icon, '☀️');
    });

    test('Parse null returns null', () {
      expect(manager.parseWeatherData(null), isNull);
    });

    test('Parse incomplete data returns defaults', () {
      final data = {'city': 'Test'};
      final weather = manager.parseWeatherData(data);
      expect(weather!.temperatureCelsius, 0);
      expect(weather.description, 'N/A');
      expect(weather.humidity, 0);
      expect(weather.windSpeed, 0);
      expect(weather.icon, '❓');
    });
  });
}
