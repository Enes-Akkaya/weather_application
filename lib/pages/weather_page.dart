import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:weather_application/services/weather_service.dart';
import '../models/weather_model.dart';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  State<WeatherPage> createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  final _weatherService =
      WeatherService(apiKey: 'd9aa9940f804ae2f34085a694341a242');
  Weather? _weather;

  _fetchWeather() async {
    final cityName = await _weatherService.getCityName();
    try {
      final weather = await _weatherService.getWeather(cityName);
      setState(() {
        _weather = weather;
      });
    } catch (e) {
      print(e);
    }
  }

  String getAnimation(String? mainCondition) {
    if (mainCondition == null) {
      return 'assets/rainy.json';
    }
    switch (mainCondition) {
      case 'Thunderstorm':
        return 'assets/thunder.json';
      case 'Drizzle':
        return 'assets/rainy.json';
      case 'Rain':
        return 'assets/rainy.json';
      case 'Clouds':
        return 'assets/cloudy.json';
      case 'Clear':
        return 'assets/sunny.json';
      default:
        return 'assets/rainy.json';
    }
  }

  @override
  void initState() {
    super.initState();
    _fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlueAccent,
      body: Center(
        child: _weather == null
            ? CircularProgressIndicator(color: Colors.white)
            : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      _weather?.cityName ?? 'City',
                      style: const TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 20),
                    Lottie.asset(
                      getAnimation(_weather?.mainCondition),
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      '${_weather?.temperature ?? 0} °C',
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      _weather?.mainCondition ?? '',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w400,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
