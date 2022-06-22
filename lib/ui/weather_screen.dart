import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_flutter/bloc/weather_bloc.dart';
import 'package:weather_flutter/domain/city_weather.dart';
import 'package:weather_flutter/domain/weather_event.dart';
import 'package:weather_flutter/domain/weather_state.dart';

class WeatherScreen extends StatefulWidget {
  const WeatherScreen({super.key, required this.city});

  final String city;

  @override
  State<StatefulWidget> createState() {
    return _WeatherScreenState();
  }
}

class _WeatherScreenState extends State<WeatherScreen> {
  late CityWeather _weatherModel;
  final WeatherBloc _bloc = WeatherBloc();

  @override
  void initState() {
    _bloc.add(GetCityWeather(widget.city));
    super.initState();
  }

  // void _getData() async {
  //   _weatherModel = (await ApiService().getCityWeather(widget.city))!;
  //   Future.delayed(const Duration(seconds: 1)).then((value) => setState(() {}));
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.city),
        ),
        body: _buildWeatherDisplay());
  }

  Widget _buildWeatherDisplay() {
    return Container(
      margin: const EdgeInsets.all(8),
      child: BlocProvider(
        create: (_) => _bloc,
        child: BlocListener<WeatherBloc, WeatherState>(
          listener: (context, state) {
            if (state is WeatherError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(state.message!),
              ));
            }
          },
          child: BlocBuilder<WeatherBloc, WeatherState>(
            builder: (context, state) {
              if (state is WeatherLoading) {
                return _buildLoading();
              } else if (state is WeatherError) {
                return _buildError();
              } else if (state is WeatherSuccess) {
                return _buildSuccess(state.cityWeather);
              } else {
                return Container();
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildLoading() => const Center(child: CircularProgressIndicator());

  Widget _buildError() => const Center(child: Text("Something went wrong..."));

  Widget _buildSuccess(CityWeather model) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
              padding: const EdgeInsets.fromLTRB(0, 16, 9, 0),
              child: Center(
                child: Image.network(model.image),
              )),
          Center(
            child: Text(
              model.description,
              style: const TextStyle(fontSize: 24),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "lat ${model.lat}",
                style: const TextStyle(fontSize: 24),
              ),
              Text(
                "lon ${model.lon}",
                style: const TextStyle(fontSize: 24),
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                "temp ${model.temp}",
                style: const TextStyle(fontSize: 24),
              ),
              Text(
                "hum ${model.humidity}",
                style: const TextStyle(fontSize: 24),
              )
            ],
          ),
          Center(
            child: Text(
              "Wind ${model.windSpeed}",
              style: const TextStyle(fontSize: 24),
            ),
          )
        ],
      ),
    );
  }
}
