import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'bloc/weather_event.dart';
import 'bloc/weather_bloc.dart';
import 'bloc/weather_state.dart';

class WeatherPage extends StatelessWidget{
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: (){
              context.read<WeatherBloc>().add(WeatherRefreshed());
            },
          ),
        ],
      ),
      body: Center(
        child: BlocBuilder<WeatherBloc,WeatherState>(
          builder: (context, state) {
            if(state is WeatherLoading){
              return Text('Loading...');
            }

            if(state is WeatherError){
              return Text('Error! Try again!');
            }

            if(state is WeatherLoaded){
              return Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    '${state.weather.temperature}°C',
                    style: const TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '${state.weather.condition}',
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

            return Text('Welcome to the Weather App!');
          },
        ),
      ),
    );
  }
}

