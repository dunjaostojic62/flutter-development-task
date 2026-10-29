import 'package:flutter_bloc/flutter_bloc.dart';

import 'weather_event.dart';
import 'weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherInitial()){
    on<WeatherRequested>((event, emit) {
      emit(WeatherLoading());
    });

    on<WeatherRefreshed>((event, emit) {
      emit(WeatherLoading());
    });
  }
}