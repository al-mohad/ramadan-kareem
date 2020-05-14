import 'package:flutter/cupertino.dart';

class Alarm {
  String name;
  bool onOrOff;
  String time;

  Alarm({
    @required this.name,
    this.onOrOff = true,
    this.time,
  });

  switchAlarm() {
    onOrOff = !onOrOff;
  }
}
