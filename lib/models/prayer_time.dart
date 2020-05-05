import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:ramadankareem/models/alarm.dart';
import 'package:ramadankareem/utils/constants.dart';

class PrayerTime extends ChangeNotifier {
  String city;
  String country;
  var prayerTime;
  List<String> prayers;
  String day;
  String month;
  String year;
  String iftar;
  bool iftarAlarmOnOff = true;
  bool sahurAlarmOnOff = true;
  String muslimsalat = 'https://muslimsalat.com/kaduna/daily.json?key=$kAPIKEY';

  void getPrayerData() async {
    day = await (DateTime.now().day - 1).toString();
    month = await DateTime.now().month.toString();
    year = await DateTime.now().year.toString();
    String aladhan =
        'http://api.aladhan.com/v1/calendarByCity?city=kaduna&country=Nigeria&method=$day&month=$month&year=$year';

    http.Response response = await http.get(muslimsalat);
    if (response.statusCode == 200) {
      String prayerData = response.body;

      city = jsonDecode(prayerData)['state'];
      country = jsonDecode(prayerData)['country'];
      iftar = jsonDecode(prayerData)['items'][0]['maghrib'];
      print(
          'IFTAR TIME*****************************************************: $country, $iftar');
    } else {
      print(response.statusCode);
    }
  }

  getLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      print(position);
    } catch (e) {
      print(e);
    }
  }

  List<Alarm> alarms = [];

  void iftarAlarm(Alarm alarm) {
    alarm.switchAlarm();
    notifyListeners();
  }
}
