import 'dart:convert';
import 'dart:developer';

import 'package:weather_flutter/data/weather_data.dart';
import 'package:http/http.dart' as http;
import 'package:weather_flutter/domain/city_weather.dart';

//https://api.openweathermap.org/data/2.5/weather?q=London&appid=c47829d28596bcea9b8793a6f45fb789

const URL = "https://api.openweathermap.org/data/2.5/weather?";
const KEY = "c47829d28596bcea9b8793a6f45fb789";

class ApiService {
  Future<CityWeather?> getCityWeather(String city) async {
    try {
      var url = Uri.parse("${URL}q=$city&appid=$KEY");
      var response = await http.get(url);
      if (response.statusCode == 200) {
        final parsed = jsonDecode(response.body);
        print('WWWWWWWWWWWWWWWWWW${parsed.runtimeType} : ${parsed}');
        WeatherData model = weatherDataFromJson(response.body);
        CityWeather result = model.fromWeatherDataToCityWeather();

        return result;
      }
    } catch (e) {
      log(e.toString());
    }
    return null;
  }
}
