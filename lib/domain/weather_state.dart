import 'package:equatable/equatable.dart';
import 'package:weather_flutter/domain/city_weather.dart';

abstract class WeatherState extends Equatable {
  const WeatherState();

  @override
  List<Object?> get props => [];
}

class WeatherLoading extends WeatherState {}

class WeatherEmpty extends WeatherState {}

class WeatherError extends WeatherState {
  final String? message;
  const WeatherError(this.message);
}

class WeatherSuccess extends WeatherState {
  final CityWeather cityWeather;
  const WeatherSuccess(this.cityWeather);
}