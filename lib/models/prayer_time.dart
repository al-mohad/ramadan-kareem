import 'dart:collection';
import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:ramadankareem/models/alarm.dart';
import 'package:ramadankareem/utils/constants.dart';
import 'package:ramadankareem/utils/functions.dart';

// This is a Singleton class, meaning only one object
// can be created from this class. If another object is
// initialized, the first object instance would be returned.
class PrayerTime extends ChangeNotifier {
  // singleton
  static final PrayerTime _prayerTime = PrayerTime._internal();

  factory PrayerTime() {
    instance++;
    return _prayerTime;
  }

  PrayerTime._internal(); // private constructor

  static int instance = 0;

  List<Alarm> _alarms = [
    Alarm(name: 'Fajr'),
    Alarm(name: 'Dhuhr'),
    Alarm(name: 'Asr'),
    Alarm(name: 'Magrib'),
    Alarm(name: 'Isha')
  ];

  List<String> prayers = [
    'Fajr',
    'Dhuhr',
    'Asr',
    'Maghrib',
    'Isha',
  ];

  String sahur;

  bool iftarAlarmOnOff = true;
  bool sahurAlarmOnOff = true;
  bool prayerAlarmOnOff = true;

  Alarm nextAlarm;

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
  int day, month, year;

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
    timestamp = DateTime.now().millisecondsSinceEpoch;
    day = DateTime.now().day;
    month = DateTime.now().month;
    year = DateTime.now().year;

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

    if (response.statusCode == 200) {
      var decodedJson = jsonDecode(response.body);

      sahur = fajrToSahur(decodedJson['data'][day - 1]['timings']['Fajr']);

      for (int i = 0; i < alarms.length; i++) {
        String s =
            apiToTime(decodedJson['data'][day - 1]['timings'][prayers[i]]);

        DateTime d = apiToDateTime(s, year, month, day);

        setTimes(alarms[i], s, d);
      }
      setNextAlarm();
    } else {
      print(response.statusCode);
      print('could not get prayerData');
      setNextAlarm();
    }

    notifyListeners();
  }

  // Alarms

  UnmodifiableListView get alarms {
    return UnmodifiableListView(_alarms);
  }

  void setTimes(Alarm alarm, String s, DateTime d) {
    alarm.setSTime = s;
    alarm.setDTime = d;

    print('${alarm.name}: ${alarm.getSTime} :: ${alarm.getDTime}');
  }

  void setNextAlarm() {
    removePreviousAlarm();
    for (Alarm alarm in alarms) {
      var now = DateTime(2020, 5, 18, 9, 30);
      var prayer = alarm.getDTime;

      if (now.isBefore(prayer)) {
        nextAlarm = alarm;
        break;
      }
      nextAlarm = alarms[0];
    }
    updateAlarm(nextAlarm, true);
  }

  void updateAlarm(Alarm alarm, bool onOff) {
    alarm.toogleNextAlarm(onOff);
    notifyListeners();
  }

  void removePreviousAlarm() {
    if (nextAlarm != null) {
      updateAlarm(nextAlarm, false);
    }
  }
}
