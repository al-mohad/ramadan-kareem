import 'dart:convert';

import 'package:ramadankareem/services/location.dart';
import 'package:ramadankareem/services/networking.dart';
import 'package:ramadankareem/utils/constants.dart';

const apiKey = '5bdeeebf079620d56c4fddedf1b809f8';
const openWeatherUrl = 'https://api.openweathermap.org/data/2.5/weather';

class WeatherModel {
  NetworkHelper networkHelper;
  Location location;

  Future<dynamic> getCityWeather(String cityName) async {
    networkHelper = NetworkHelper(
        url: '$openWeatherUrl?q=$cityName&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();
    return weatherData;
  }

  Future<dynamic> getLocationWeather() async {
    location = Location();

    networkHelper = NetworkHelper(
        url:
            '$openWeatherUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    print(
        '$openWeatherUrl?lat=${location.latitude}&lon=${location.longitude}&appid=$apiKey&units=metric');

    var weatherData = await networkHelper.getData();

    if (weatherData == null) {
      weatherData = jsonDecode(dummyWeather.body);
    }
    print('getLocationWeather exitted');
    return weatherData;
  }
}
