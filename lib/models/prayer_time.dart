import 'dart:collection';
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
    day = (DateTime.now().day - 1).toString();
    month = DateTime.now().month.toString();
    year = DateTime.now().year.toString();
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

  stringToTime(String fajr) {
    String i = '4:14 am';

    int indexOfColon = fajr.indexOf(':');
    int hrty = int.parse(fajr.substring(0, indexOfColon));
    print('hrty: $hrty');
    int minty = int.parse(fajr.substring(indexOfColon + 1, indexOfColon + 2));
    minty -= 5;
    print('minty: $minty');

    if (minty.isNegative) {
      hrty -= 1;
      minty += 6;
    }
    print('new  hrty: $hrty');
    print('new minty: $minty');

    String n = hrty.toString();
    n += fajr.substring(indexOfColon, indexOfColon + 1);
    n += minty.toString();
    n += fajr.substring(indexOfColon + 2, i.length);

    print('fajr: $fajr');
    print('Sahur Alert: $n');
    return n;
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

  List<Alarm> _alarms = [
    Alarm(name: 'Fajr'),
    Alarm(name: 'Dhuhr'),
    Alarm(name: 'Asr'),
    Alarm(name: 'Magrib'),
    Alarm(name: 'Isha')
  ];

  UnmodifiableListView get alarms {
    return UnmodifiableListView(_alarms);
  }

  void updateAlarm(Alarm alarm) {
    alarm.switchAlarm();
    notifyListeners();
  }
}
