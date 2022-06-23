import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_flutter/data/weather_repository.dart';
import 'package:weather_flutter/domain/weather_state.dart';

class WeatherCubit extends Cubit<WeatherState> {
  WeatherCubit(this._weatherRepository) : super(WeatherEmpty());

  final WeatherRepository _weatherRepository;

  Future<void> getWeather(String city) async {
    try {
      emit(WeatherLoading());

      final cityWeather = await _weatherRepository.fetchCityWeather(city);

      if (cityWeather != null) {
        emit(WeatherSuccess(cityWeather));
      } else {
        emit(WeatherEmpty());
      }
    } on Exception catch (exception) {
      emit(WeatherError(exception.toString()));
    }
  }
}
