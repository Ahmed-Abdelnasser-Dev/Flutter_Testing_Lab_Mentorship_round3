import 'package:flutter/material.dart';
import 'package:flutter_testing_lab/logic/weather_manager.dart';
import 'package:flutter_testing_lab/models/weather_data.dart';

class WeatherDisplay extends StatefulWidget {
  const WeatherDisplay({super.key});

  @override
  State<WeatherDisplay> createState() => _WeatherDisplayState();
}

class _WeatherDisplayState extends State<WeatherDisplay> {
  final WeatherManager _manager = WeatherManager();
  WeatherData? _weatherData;
  bool _isLoading = false;
  String? _error;
  bool _useFahrenheit = false;
  String _selectedCity = 'New York';

  final List<String> _cities = ['New York', 'London', 'Tokyo', 'Invalid City'];

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  Future<void> _loadWeather() async {
    setState(() {
      _isLoading = true;
      _error = null;
    });

    try {
      final data = await _manager.fetchWeatherData(_selectedCity);
      final parsed = _manager.parseWeatherData(data);
      if (parsed == null) {
        throw Exception('Failed to load weather data');
      }
      setState(() {
        _weatherData = parsed;
      });
    } catch (e) {
      setState(() {
        _error = e.toString();
        _weatherData = null;
      });
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // City selection
            Row(
              children: [
                const Text('City: '),
                const SizedBox(width: 8),
                Expanded(
                  child: DropdownButton<String>(
                    value: _selectedCity,
                    isExpanded: true,
                    items: _cities
                        .map(
                          (city) =>
                              DropdownMenuItem(value: city, child: Text(city)),
                        )
                        .toList(),
                    onChanged: (value) {
                      if (value != null) {
                        setState(() => _selectedCity = value);
                        _loadWeather();
                      }
                    },
                  ),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: _loadWeather,
                  child: const Text('Refresh'),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Temperature unit toggle
            Row(
              children: [
                const Text('Temperature Unit:'),
                const SizedBox(width: 10),
                Switch(
                  value: _useFahrenheit,
                  onChanged: (value) => setState(() => _useFahrenheit = value),
                ),
                Text(_useFahrenheit ? 'Fahrenheit' : 'Celsius'),
              ],
            ),
            const SizedBox(height: 16),

            // Loading / Error / Weather card
            if (_isLoading)
              const Center(child: CircularProgressIndicator())
            else if (_error != null)
              Center(
                child: Text(_error!, style: const TextStyle(color: Colors.red)),
              )
            else if (_weatherData != null)
              Card(
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Text(
                            _weatherData!.icon,
                            style: const TextStyle(fontSize: 48),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  _weatherData!.city,
                                  style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  _weatherData!.description,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Center(
                        child: Text(
                          _useFahrenheit
                              ? '${_manager.celsiusToFahrenheit(_weatherData!.temperatureCelsius).toStringAsFixed(1)}°F'
                              : '${_weatherData!.temperatureCelsius.toStringAsFixed(1)}°C',
                          style: const TextStyle(
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          _buildWeatherDetail(
                            'Humidity',
                            '${_weatherData!.humidity}%',
                            Icons.water_drop,
                          ),
                          _buildWeatherDetail(
                            'Wind Speed',
                            '${_weatherData!.windSpeed} km/h',
                            Icons.air,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildWeatherDetail(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.blue, size: 32),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        Text(
          value,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
