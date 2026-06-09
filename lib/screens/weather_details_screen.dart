import 'package:flutter/material.dart';

import '../models/weather.dart';

class WeatherDetailsScreen extends StatelessWidget {
  final Weather weather;

  const WeatherDetailsScreen({super.key, required this.weather});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("7-Day Forecast")),

      body: ListView.builder(
        itemCount: weather.dailyForecasts.length,

        itemBuilder: (context, index) {
          final forecast = weather.dailyForecasts[index];

          return Card(
            margin: const EdgeInsets.all(8),

            child: ListTile(
              leading: const Icon(Icons.calendar_today),

              title: Text(forecast.date),

              subtitle: Text('Min: ${forecast.minTemperature}°C'),

              trailing: Text(
                '${forecast.maxTemperature}°C',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
