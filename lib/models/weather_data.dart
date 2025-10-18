class WeatherData {
  final String city;
  final double temperatureCelsius;
  final String description;
  final int humidity;
  final double windSpeed;
  final String icon;

  WeatherData({
    required this.city,
    required this.temperatureCelsius,
    required this.description,
    required this.humidity,
    required this.windSpeed,
    required this.icon,
  });

  factory WeatherData.fromJson(Map<String, dynamic>? json) {
    if (json == null) {
      throw Exception('Invalid weather data');
    }

    return WeatherData(
      city: json['city'] ?? 'Unknown',
      temperatureCelsius: (json['temperature'] ?? 0).toDouble(),
      description: json['description'] ?? 'N/A',
      humidity: json['humidity'] ?? 0,
      windSpeed: (json['windSpeed'] ?? 0).toDouble(),
      icon: json['icon'] ?? '❓',
    );
  }
}
