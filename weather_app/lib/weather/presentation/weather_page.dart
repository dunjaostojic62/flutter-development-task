import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/weather_bloc.dart';
import 'bloc/weather_state.dart';

class WeatherPage extends StatelessWidget{
  const WeatherPage({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Weather'),
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
              return Text('Data is successfully loaded!');
            }

            return Text('Welcome to the Weather App!');
          },
        ),
      ),
    );
  }
}

