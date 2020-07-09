import 'package:flutter/material.dart';

class Alarm {
  String name;
  bool isNext;
  String _stringTime;
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

  void toggleNextAlarm(bool onOff) {
    isNext = onOff;
  }
}
