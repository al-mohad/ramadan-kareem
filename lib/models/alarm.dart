class Alarm {
  String name;
  bool onOrOff;
  String time;
  Alarm({this.name, this.onOrOff = false, this.time});
  switchAlarm() {
    onOrOff = !onOrOff;
  }
}
