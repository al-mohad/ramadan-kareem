import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:ramadankareem/models/alarm.dart';
import 'package:ramadankareem/utils/constants.dart';

class PrayerTime extends ChangeNotifier {
  // singleton
  static final PrayerTime _prayerTime = PrayerTime._internal();

  factory PrayerTime() {
    instance++;
    return _prayerTime;
  }

  PrayerTime._internal(); // private constructor

  static int instance = 0;

  String sahur;
  String fajr;
  String iftar;

  bool iftarAlarmOnOff = true;
  bool sahurAlarmOnOff = true;

  String muslimsalat = 'https://muslimsalat.com/kaduna/daily.json?key=$kAPIKEY';

  String timings = 'http://api.aladhan.com/v1/timings';
  String timingsByAddress = 'http://api.aladhan.com/v1/timingsByAddress';
  String timingsByCity = 'http://api.aladhan.com/v1/timingsByCity';
  String calenderByCity = 'http://api.aladhan.com/v1/calendarByCity';

  int timestamp; // Number of seconds since Epoch
  Position position;
  int method = 2; // 2 for Islamic Society of North America ISNA
  int school = 0; // 0 for Shafii, Maliki & Hanbali while 1 for Hanafi
  String address = 'Central Mosque, Abuja, Nigeria';
  String city = 'Kaduna';
  String state = 'Kaduna';
  String country = 'Nigeria';
  String timezone;
  String month, year;
  int day;

  getLocation() async {
    try {
      position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      print(position);
    } catch (e) {
      print(e);
    }

    getPrayerData();
  }

  getPrayerData() async {
    print('getPrayerData() has been called');
    timestamp = DateTime.now().microsecondsSinceEpoch;
    day = DateTime.now().day;
    month = DateTime.now().month.toString();
    year = DateTime.now().year.toString();

    print('DD-MM-YYYY: $day-$month-$year');

    timings += '/$timestamp';
    timings += '?latitude=${position.latitude}';
    timings += '&longitude=${position.longitude}';
    timings += '&method=$method';
    timings += '&school=$school';
    // print('url: $timings');

    timingsByAddress += '?address=$address';
    timingsByAddress += '&method=$method';
    timingsByAddress += '&school=$school';

    timingsByCity += '?city=$city';
    timingsByCity += '&state=$state';
    timingsByCity += '&country=$country';
    timingsByCity += '&method=$method';
    timingsByCity += '&school=$school';

    calenderByCity += '?city=$city';
    calenderByCity += '&country=$country';
    calenderByCity += '&method=$method';
    calenderByCity += '&month=$month';
    calenderByCity += '&year=$year';
    print('url: $calenderByCity');

    http.Response response = await http.get(calenderByCity);
    print("response: ${response.body}");

    if (response.statusCode == 200) {
      String prayerData = response.body;

      iftar = jsonDecode(prayerData)['data'][day - 1]['timings']
          ['Maghrib']; //data.timings.Maghrib
      fajr = jsonDecode(prayerData)['data'][day - 1]['timings']
          ['Fajr']; // data[13].timings.Fajr
      timezone = jsonDecode(prayerData)['data'][day - 1]['meta']['timezone'];
      sahur = fajrToSahur(fajr);
      String meth =
          jsonDecode(prayerData)['data'][day - 1]['meta']['method']['name'];
      print('SAHUR TIME*************************: $timezone, $meth');
    } else {
      print(response.statusCode);
      print('could not get prayerData');
    }

    notifyListeners();
  }

  fajrToSahur(String fajr) {
    // Format of String fajr = 17:37';

    fajr += ' ';

    int indexOfColon = fajr.indexOf(':');
    int hrty = int.parse(fajr.substring(0, indexOfColon));
    print('hrty: $hrty');
    int minty = int.parse(fajr.substring(indexOfColon + 1, indexOfColon + 3));
    print('minty: $minty');

    minty -= 50;
    if (minty.isNegative) {
      hrty = hrty == 0 ? 24 - 1 : hrty - 1;
      minty += 60;
    }
    print('new hrty: $hrty');
    print('new minty: $minty');

    String n = hrty < 10 ? '0$hrty' : hrty.toString();
    n += ':';
    n += minty < 10 ? '0$minty' : minty.toString();
    n += hrty < 12 ? ' am' : ' pm';

    print('fajr: $fajr');
    print('Sahur Alert: $n');
    return n;
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
