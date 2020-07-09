import 'package:ramadankareem/notifiers/alarm_notifier.dart';
import 'package:ramadankareem/services/networking.dart';
import 'package:ramadankareem/utils/functions.dart';

int timestamp; // Number of seconds since Epoch
int method = 2; // 2 for Islamic Society of North America ISNA
int school = 0; // 0 for Shafii, Maliki & Hanbali while 1 for Hanafi
String address = 'Central Mosque, Abuja, Nigeria';
String city = 'Kaduna';
String state = 'Kaduna';
String country = 'Nigeria';

List<String> prayers = [
  'Fajr',
  'Dhuhr',
  'Asr',
  'Maghrib',
  'Isha',
];

getTimingsData() async {
  String timings = 'http://api.aladhan.com/v1/timings';

  // timings += '/$timestamp';
  // timings += '?latitude=${position.latitude}';
  // timings += '&longitude=${position.longitude}';
  // timings += '&method=$method';
  // timings += '&school=$school';
  // print('url: $timings');
}

getTimingsDataByAddress() async {
  String timingsByAddress = 'http://api.aladhan.com/v1/timingsByAddress';

  // timingsByAddress += '?address=$address';
  // timingsByAddress += '&method=$method';
  // timingsByAddress += '&school=$school';
}

getTimingsDataByCity() async {
  String timingsByCity = 'http://api.aladhan.com/v1/timingsByCity';

  // timingsByCity += '?city=$city';
  // timingsByCity += '&state=$state';
  // timingsByCity += '&country=$country';
  // timingsByCity += '&method=$method';
  // timingsByCity += '&school=$school';
}

getCalenderDataByCity(AlarmNotifier alarmNotifier) async {
  String calenderByCity = 'http://api.aladhan.com/v1/calendarByCity';

  int day = DateTime.now().day;
  int month = DateTime.now().month;
  int year = DateTime.now().year;

  String url = '';
  url += calenderByCity;
  url += '?city=$city';
  url += '&country=$country';
  url += '&method=$method';
  url += '&month=$month';
  url += '&year=$year';
  print('url: $url');

  NetworkHelper timeNetworkHelper = NetworkHelper(url: url);
  var timeData = await timeNetworkHelper.getData();

  if (timeData != null) {
    String hur = fajrToSahur(timeData['data'][day - 1]['timings']['Fajr']);
    String tar = apiToTime(timeData['data'][day - 1]['timings']['Maghrib']);

    String hurSTime = apiToTime(hur);
    DateTime hurDTime = apiToDateTime(hurSTime, year, month, day);
    alarmNotifier.setSahurAlarm(hurSTime, hurDTime);

    String tarSTime = apiToTime(tar);
    DateTime tarDTime = apiToDateTime(tarSTime, year, month, day);
    alarmNotifier.setIftarAlarm(tarSTime, tarDTime);

    for (int i = 0; i < 5; i++) {
      String s = apiToTime(timeData['data'][day - 1]['timings'][prayers[i]]);

      DateTime d = apiToDateTime(s, year, month, day);

      alarmNotifier.setAlarmTime(i, s, d);
    }

    alarmNotifier.setNextAlarmTime();
  }
}
