import 'dart:convert';

import 'package:ramadankareem/services/location.dart';
import 'package:ramadankareem/services/networking.dart';
import 'package:ramadankareem/utils/constants.dart';

const apiKey = '5bdeeebf079620d56c4fddedf1b809f8';
const openWeatherUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  // singleton_start
  static final WeatherModel _weatherModel = WeatherModel._internal();

  factory WeatherModel() {
    instance++;
    return _weatherModel;
  }

  WeatherModel._internal(); // private constructor

  static int instance = 0;
  // singleton_end

  dynamic data;
  NetworkHelper networkHelper;

  Future<dynamic> getCityWeather(String cityName) async {
    networkHelper = NetworkHelper(
        url: '$openWeatherUrl?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    data = weatherData;
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    Location location = Location();

    networkHelper = NetworkHelper(
        url:
            '$openWeatherUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    print(
        '$openWeatherUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    if (weatherData == null) {
      weatherData = jsonDecode(dummyWeather.body);
    }
    print('getLocationWeather exited');
    data = weatherData;
    return weatherData;
  }
}
