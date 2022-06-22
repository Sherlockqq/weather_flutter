
import 'package:equatable/equatable.dart';

abstract class WeatherEvent extends Equatable {
  const WeatherEvent();

  @override
  List<Object> get props => [];
}

class GetCityWeather extends WeatherEvent {
  final String city;
  const GetCityWeather(this.city);
}