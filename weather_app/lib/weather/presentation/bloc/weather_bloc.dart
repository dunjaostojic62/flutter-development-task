import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/weather/domain/repositories/weather_repository.dart';

import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {

  final WeatherRepository repository;

  WeatherBloc(this.repository) : super(WeatherInitial()){
    on<WeatherRequested>((event, emit) async{
      await _fetchWeather(event.city, emit);
    });

    on<WeatherRefreshed>((event, emit) async{
      await _fetchWeather(event.city,emit);
    });
  }

  Future<void> _fetchWeather(
    String city,
    Emitter<WeatherState> emit) async {
    emit(WeatherLoading());

    try{
      final weather = await repository.getWeather(city);
      emit(WeatherLoaded(weather));
    }
    catch(e){
      emit(WeatherError());
    }
  }
}


