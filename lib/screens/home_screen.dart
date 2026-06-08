import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/weather_provider.dart';

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
      appBar: AppBar(title: const Text('Weather App')),
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
                  style: const TextStyle(color: Colors.red),
                ),
              ),

            if (provider.city != null && provider.weather != null)
              Card(
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

                      Text('Wiatr: ${provider.weather!.windSpeed} km/h'),
                    ],
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
