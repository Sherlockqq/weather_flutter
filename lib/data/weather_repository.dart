
import 'package:weather_flutter/data/api_service.dart';

import '../domain/city_weather.dart';

class WeatherRepository {
  final _service = ApiService();

  Future<CityWeather?> fetchCityWeather(String city) {
    return _service.getCityWeather(city);
  }
}

