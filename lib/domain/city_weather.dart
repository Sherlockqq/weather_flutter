class CityWeather {
  CityWeather(
      {required this.id,
      required this.city,
      required this.lat,
      required this.lon,
      required this.description,
      required this.windSpeed,
      required this.humidity,
      required this.temp,
      required this.image});

  int id;
  String city;
  double lat;
  double lon;
  String description;
  double windSpeed;
  int humidity;
  double temp;
  String image;
}
