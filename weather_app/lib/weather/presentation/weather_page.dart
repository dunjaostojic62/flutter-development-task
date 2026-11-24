
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/weather/domain/hourly_weather.dart';

import 'bloc/weather_bloc.dart';
import 'bloc/weather_event.dart';
import 'bloc/weather_state.dart';
import 'weather_atmosphere.dart';

class WeatherPage extends StatelessWidget {
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherBloc, WeatherState>(
      builder: (context, state) {
        final bool isDay =
            Theme.of(context).brightness == Brightness.light;

        return Scaffold(
          backgroundColor: Colors.transparent,
          body: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: isDay
                    ? [
                        const Color(0xFF87CEFA),
                        const Color(0xFF6DD5FA),
                        const Color(0xFFFFFFFF),
                      ]
                    : [
                        const Color(0xFF0F2027),
                        const Color(0xFF203A43),
                        const Color(0xFF2C5364),
                      ],
              ),
            ),
            child: Stack(
              children: [
                Positioned.fill(
                  child: BlocBuilder<WeatherBloc, WeatherState>(
                    buildWhen: (previous, current) {
                      return current is WeatherLoaded;
                    },
                    builder: (context, atmosphereState) {
                      return WeatherAtmosphere(
                        condition: atmosphereState is WeatherLoaded
                            ? atmosphereState.weather.condition
                            : '',
                        isDay: atmosphereState is WeatherLoaded
                            ? atmosphereState.weather.isDay
                            : isDay,
                      );
                    },
                  ),
                ),
                SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        _buildHeader(context),
                        const SizedBox(height: 20),
                        _buildSearchBar(context),
                        const SizedBox(height: 24),
                        Expanded(
                          child: Center(
                            child: _buildBody(state),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      children: [
        const Text(
          'Weather',
          style: TextStyle(
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
        const Spacer(),
        _GlassIconButton(
          icon: Icons.refresh,
          onPressed: () {
            context.read<WeatherBloc>().add(
              WeatherRefreshed(),
            );
          },
        ),
      ],
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return _GlassCard(
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 6,
      ),
      child: TextField(
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
        decoration: const InputDecoration(
          icon: Icon(
            Icons.search,
            color: Colors.white,
          ),
          hintText: 'Search city...',
          hintStyle: TextStyle(
            color: Colors.white70,
          ),
          border: InputBorder.none,
        ),
        onSubmitted: (city) {
          final trimmedCity = city.trim();

          if (trimmedCity.isNotEmpty) {
            context.read<WeatherBloc>().add(
              WeatherRequested(trimmedCity),
            );
          }
        },
      ),
    );
  }

  Widget _buildBody(WeatherState state) {
    if (state is WeatherLoading) {
      return _GlassCard(
        width: double.infinity,
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CircularProgressIndicator(
                color: Colors.white,
              ),
              SizedBox(height: 16),
              Text(
                'Loading...',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (state is WeatherError) {
      return _GlassCard(
        width: double.infinity,
        child: const Padding(
          padding: EdgeInsets.symmetric(vertical: 40),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 48,
              ),
              SizedBox(height: 16),
              Text(
                'Error! Try again!',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      );
    }

    if (state is WeatherLoaded) {
      final weather = state.weather;

      return SingleChildScrollView(
        child: Column(
          children: [
            _GlassCard(
              width: double.infinity,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 28,
                ),
                child: Column(
                  children: [
                    Icon(
                      _getWeatherIcon(
                        weather.condition,
                        weather.isDay,
                      ),
                      size: 64,
                      color: Colors.white,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      weather.city,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 34,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'Caveat',
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${weather.temperature.toStringAsFixed(1)}°C',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 54,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      weather.condition,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Expanded(
                  child: _InfoCard(
                    title: 'Feels like',
                    value:
                        '${weather.feelsLike.toStringAsFixed(1)}°C',
                    icon: Icons.thermostat,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: _InfoCard(
                    title: 'Wind speed',
                    value:
                        '${weather.windSpeed.toStringAsFixed(1)} km/h',
                    icon: Icons.air,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Hourly forecast',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
            const SizedBox(height: 16),
            _buildHourlyForecast(weather.hourlyForecast),
          ],
        ),
      );
    }

    return _GlassCard(
      width: double.infinity,
      child: const Padding(
        padding: EdgeInsets.symmetric(vertical: 40),
        child: Text(
          'Welcome to the Weather App!',
          textAlign: TextAlign.center,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget _buildHourlyForecast(List<HourlyWeather> forecast) {
    return SizedBox(
      height: 150,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: forecast.length,
        separatorBuilder: (context, index) {
          return const SizedBox(width: 12);
        },
        itemBuilder: (context, index) {
          final hour = forecast[index];

          final formattedTime =
              '${hour.time.hour.toString().padLeft(2, '0')}:00';

          return _GlassCard(
            width: 110,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  formattedTime,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 15,
                  ),
                ),
                Icon(
                  _getWeatherIcon(
                    hour.condition,
                    hour.isDay,
                  ),
                  color: Colors.white,
                  size: 32,
                ),
                Text(
                  '${hour.temperature.toStringAsFixed(0)}°',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  IconData _getWeatherIcon(String condition, bool isDay) {
    final lowerCondition = condition.trim().toLowerCase();

    if (lowerCondition.contains('thunder')) {
      return Icons.flash_on;
    }

    if (lowerCondition.contains('rain') ||
        lowerCondition.contains('drizzle')) {
      return Icons.grain;
    }

    if (lowerCondition.contains('snow')) {
      return Icons.ac_unit;
    }

    if (lowerCondition.contains('fog')) {
      return Icons.blur_on;
    }

    if (lowerCondition.contains('cloud') ||
        lowerCondition.contains('overcast')) {
      return Icons.cloud;
    }

    if (lowerCondition.contains('clear')) {
      return isDay
          ? Icons.wb_sunny_rounded
          : Icons.nightlight_round;
    }

    // Nepoznat vremenski opis ne prikazujemo kao sunce.
    return Icons.help_outline;
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;
  final IconData icon;

  const _InfoCard({
    required this.title,
    required this.value,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 20,
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: Colors.white,
              size: 28,
            ),
            const SizedBox(height: 12),
            Text(
              title,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 15,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              value,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _GlassIconButton extends StatelessWidget {
  final IconData icon;
  final VoidCallback onPressed;

  const _GlassIconButton({
    required this.icon,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return _GlassCard(
      borderRadius: 18,
      padding: EdgeInsets.zero,
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(
          icon,
          color: Colors.white,
        ),
      ),
    );
  }
}

class _GlassCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final double borderRadius;
  final double? width;

  const _GlassCard({
    required this.child,
    this.padding,
    this.borderRadius = 24,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(borderRadius),
      child: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 14,
          sigmaY: 14,
        ),
        child: Container(
          width: width,
          padding: padding ?? const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: Colors.white.withValues(alpha: 0.16),
            border: Border.all(
              color: Colors.white.withValues(alpha: 0.22),
              width: 1.2,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withValues(alpha: 0.08),
                blurRadius: 18,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: child,
        ),
      ),
    );
  }
}
