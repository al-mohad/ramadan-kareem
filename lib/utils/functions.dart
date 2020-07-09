import 'package:ramadankareem/utils/constants.dart';

apiToDateTime(String time, int year, int month, int day) {
  // Change a string time & date to a DateTime object
  // e.g 21:38 17-5-2020 to DD-MM-YYYY-HH:MM:SS

  int hour, minute;

  time += ' ';
  int indexOfColon = time.indexOf(':');

  hour = int.parse(time.substring(0, indexOfColon));
  minute = int.parse(time.substring(indexOfColon + 1, indexOfColon + 3));

  return DateTime(year, month, day, hour, minute);
}

apiToTime(String time) {
  // Change any time formated string to HH:MM
  int hour, minute;

  time += ' ';
  int indexOfColon = time.indexOf(':');

  hour = int.parse(time.substring(0, indexOfColon));
  minute = int.parse(time.substring(indexOfColon + 1, indexOfColon + 3));

  String newTime = hour < 10 ? '0$hour' : hour.toString();
  newTime += ':';
  newTime += minute < 10 ? '0$minute' : minute.toString();

  print('apiToTime: $newTime');
  return newTime;
}

fajrToSahur(String fajr) {
  // Format of String fajr = 05:07 (WAT)';
  int indexOfColon = fajr.indexOf(':');
  int hrty = int.parse(fajr.substring(0, indexOfColon));
  int minty = int.parse(fajr.substring(indexOfColon + 1, indexOfColon + 3));

  minty -= sahurConstant;

  if (minty.isNegative) {
    hrty = hrty == 0 ? 24 - 1 : hrty - 1;
    minty += 60;
  }

  String n = hrty < 10 ? '0$hrty' : hrty.toString();
  n += ':';
  n += minty < 10 ? '0$minty' : minty.toString();
  // n += hrty < 12 ? ' am' : ' pm';

  print('fajrToSahur: $n');
  return n;
}
