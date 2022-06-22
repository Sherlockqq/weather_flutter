import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_flutter/data/weather_repository.dart';
import 'package:weather_flutter/domain/weather_event.dart';
import 'package:weather_flutter/domain/weather_state.dart';

class WeatherBloc extends Bloc<WeatherEvent, WeatherState> {
  WeatherBloc() : super(WeatherLoading()) {
    final WeatherRepository weatherRepository = WeatherRepository();

    on<GetCityWeather>((event, emit) async {
      try {
        emit(WeatherLoading());
        final cityWeather =
            await weatherRepository.fetchCityWeather(event.city);
        if (cityWeather != null) {
          emit(WeatherSuccess(cityWeather));
        } else {
          emit(const WeatherError("Failed"));
        }
      } catch (ex) {
        emit(const WeatherError("Failed!"));
      }
    });
  }
}
