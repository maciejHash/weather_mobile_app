import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'weather_details_screen.dart';

import '../providers/weather_provider.dart';
import '../utils/weather_code_mapper.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController cityController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<WeatherProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather App'),

        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),

            onPressed: () {
              if (cityController.text.isNotEmpty) {
                provider.searchWeather(cityController.text);
              }
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: cityController,
              decoration: const InputDecoration(
                labelText: 'Miasto',
                border: OutlineInputBorder(),
              ),
            ),

            const SizedBox(height: 16),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  provider.searchWeather(cityController.text);
                },
                child: const Text('Pobierz pogodę'),
              ),
            ),

            const SizedBox(height: 24),

            if (provider.isLoading) const CircularProgressIndicator(),

            if (provider.errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 16),
                child: Text(
                  provider.errorMessage!,
                  style: const TextStyle(color: Colors.orange),
                ),
              ),

            if (provider.city != null && provider.weather != null)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,

                    MaterialPageRoute(
                      builder: (_) =>
                          WeatherDetailsScreen(weather: provider.weather!),
                    ),
                  );
                },

                child: Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),

                    child: Column(
                      children: [
                        Text(
                          provider.city!.name,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        Text(provider.city!.country),

                        const SizedBox(height: 16),

                        Text(
                          '${provider.weather!.temperature} °C',
                          style: const TextStyle(fontSize: 28),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          WeatherCodeMapper.getIcon(
                            provider.weather!.weatherCode,
                          ),
                          style: const TextStyle(fontSize: 42),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          WeatherCodeMapper.getDescription(
                            provider.weather!.weatherCode,
                          ),
                          style: const TextStyle(fontSize: 18),
                        ),

                        const SizedBox(height: 8),

                        Text('Wiatr: ${provider.weather!.windSpeed} km/h'),

                        const SizedBox(height: 12),

                        const Text("Kliknij aby zobaczyć prognozę"),
                      ],
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
