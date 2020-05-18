import 'package:flutter/cupertino.dart';

class Alarm {
  String name;
  bool isNext;
  String _stringTime = "18:28";
  DateTime _dateTime;

  Alarm({
    @required this.name,
    this.isNext = false,
  });

  get getSTime => _stringTime;
  set setSTime(String value) {
    _stringTime = value;
  }

  get getDTime => _dateTime;
  set setDTime(DateTime value) {
    _dateTime = value;
  }

  void toogleNextAlarm(bool onOff) {
    isNext = onOff;
  }
}
