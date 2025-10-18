// weather_manager.dart
import 'package:flutter_testing_lab/models/weather_data.dart';

class WeatherManager {
  final List<String> cities = ['New York', 'London', 'Tokyo', 'Invalid City'];

  // Correct conversion formulas
  double celsiusToFahrenheit(double celsius) => celsius * 9 / 5 + 32;

  double fahrenheitToCelsius(double fahrenheit) => (fahrenheit - 32) * 5 / 9;

  /// Simulate API call
  Future<Map<String, dynamic>?> fetchWeatherData(String city) async {
    await Future.delayed(const Duration(seconds: 2));

    if (city == 'Invalid City') return null;

    // Occasionally return minimal data
    if (DateTime.now().millisecond % 4 == 0) {
      return {'city': city, 'temperature': 22.5};
    }

    return {
      'city': city,
      'temperature': city == 'London' ? 15.0 : (city == 'Tokyo' ? 25.0 : 22.5),
      'description': city == 'London'
          ? 'Rainy'
          : (city == 'Tokyo' ? 'Cloudy' : 'Sunny'),
      'humidity': city == 'London' ? 85 : (city == 'Tokyo' ? 70 : 65),
      'windSpeed': city == 'London' ? 8.5 : (city == 'Tokyo' ? 5.2 : 12.3),
      'icon': city == 'London' ? '🌧️' : (city == 'Tokyo' ? '☁️' : '☀️'),
    };
  }

  WeatherData? parseWeatherData(Map<String, dynamic>? data) {
    if (data == null) return null;
    try {
      return WeatherData.fromJson(data);
    } catch (_) {
      return null;
    }
  }
}
