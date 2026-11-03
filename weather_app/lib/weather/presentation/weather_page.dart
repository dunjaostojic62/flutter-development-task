
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/weather_event.dart';
import 'bloc/weather_bloc.dart';
import 'bloc/weather_state.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Weather'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              context.read<WeatherBloc>().add(
                WeatherRefreshed('Novi Sad'),
              );
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                labelText: 'Unesi grad',
                hintText: 'Npr. London',
                border: OutlineInputBorder(),
                prefixIcon: Icon(Icons.search),
              ),
              onSubmitted: (city) {
                if (city.trim().isNotEmpty) {
                  context.read<WeatherBloc>().add(
                    WeatherRequested(city.trim()),
                  );
                }
              },
            ),
            const SizedBox(height: 24),
            Expanded(
              child: Center(
                child: BlocBuilder<WeatherBloc, WeatherState>(
                  builder: (context, state) {
                    if (state is WeatherLoading) {
                      return const Text('Loading...');
                    }

                    if (state is WeatherError) {
                      return const Text('Error! Try again!');
                    }

                    if (state is WeatherLoaded) {
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            state.weather.city,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 60,
                              fontFamily: 'Caveat',
                            ),
                          ),
                          Text(
                            '${state.weather.temperature}°C',
                            style: const TextStyle(
                              fontSize: 40,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            state.weather.condition,
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.normal,
                            ),
                          ),
                          Text(
                            'Feels like: ${state.weather.feelsLike}°C',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            'Wind speed: ${state.weather.windSpeed} km/h',
                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      );
                    }

                    return const Text('Welcome to the Weather App!');
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
