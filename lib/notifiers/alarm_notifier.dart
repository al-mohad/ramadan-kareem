import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:ramadankareem/models/alarm.dart';

class AlarmNotifier extends ChangeNotifier {
  bool prayerAlarmOnOff = true;

  Alarm _nextAlarm;
  Alarm _sahur = Alarm(name: 'Sahur');
  Alarm _iftar = Alarm(name: 'Iftar');

  List<Alarm> _alarms = [
    Alarm(name: 'Fajr'),
    Alarm(name: 'Dhuhr'),
    Alarm(name: 'Asr'),
    Alarm(name: 'Maghrib'),
    Alarm(name: 'Isha')
  ];

  UnmodifiableListView get alarms => UnmodifiableListView(_alarms);

  get sahur => _sahur;
  get iftar => _iftar;

  get nextAlarm => _nextAlarm;

  void setSahurAlarm(String s, DateTime d) {
    _sahur.setSTime = s;
    _sahur.setDTime = d;

    updateAlarmStatus(_sahur, true);
  }

  void setIftarAlarm(String s, DateTime d) {
    _iftar.setSTime = s;
    _iftar.setDTime = d;

    updateAlarmStatus(_iftar, true);
  }

  void setAlarmTime(int index, String s, DateTime d) {
    _alarms[index].setSTime = s;
    _alarms[index].setDTime = d;

    print(
        '${_alarms[index].name}: ${_alarms[index].getSTime} :: ${_alarms[index].getDTime}');
  }

  void setNextAlarmTime() {
    if (_nextAlarm != null) {
      updateAlarmStatus(_nextAlarm, false);
    }

    try {
      for (Alarm alarm in alarms) {
        var now = DateTime.now();
        var prayer = alarm.getDTime;

        if (now.isBefore(prayer)) {
          _nextAlarm = alarm;
          break;
        }
        _nextAlarm = alarms[0];
      }
    } catch (e) {
      print('##setNextAlarm##: $e');
    }

    updateAlarmStatus(_nextAlarm, true);
  }

  void updateAlarmStatus(Alarm alarm, bool onOff) {
    alarm.toggleNextAlarm(onOff);
    notifyListeners();
  }

  void notify() {
    notifyListeners();
  }
}
