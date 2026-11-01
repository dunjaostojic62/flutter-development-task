import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/weather/domain/repositories/weather_repository.dart';

import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  final WeatherRepository repository;

  WeatherBloc(this.repository) : super(WeatherInitial()){
    on<WeatherRequested>((event, emit) async{
      emit(WeatherLoading());

      try{
        final weather = await repository.getWeather();
        emit(WeatherLoaded(weather));
      }
      catch(e){
        emit(WeatherError());
      }
    });

    on<WeatherRefreshed>((event, emit) async{
      emit(WeatherLoading());

      try{
        final weather = await repository.getWeather();
        emit(WeatherLoaded(weather));
      }
      catch(e){
        emit(WeatherError());
      }
    });
  }
}