import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ramadankareem/components/back_button.dart';
import 'package:ramadankareem/components/countdown_timer.dart';
import 'package:ramadankareem/components/info_card.dart';
import 'package:ramadankareem/models/alarm.dart';
import 'package:ramadankareem/models/prayer_time.dart';
import 'package:ramadankareem/utils/constants.dart';

class CountdownScreen extends StatefulWidget {
  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  Alarm alarm;
  dynamic weatherData;
  DateTime now, later, remaining;
  Duration duration;
  String hours, minutes, seconds, city;
  int temperature;

  void getDuration() {
    try {
      now = DateTime.now();
      later = alarm.getDTime;
      duration = later.difference(now);
      remaining = DateTime.fromMillisecondsSinceEpoch(duration.inMilliseconds,
          isUtc: true);
      hours = remaining.hour.toString();
      int m = remaining.minute;
      minutes = m < 10 ? '0$m' : m.toString();
      int s = remaining.second;
      seconds = s < 10 ? '0$s' : s.toString();

      print('Now: $now');
      print('Later: $later');
      print('Duration: $duration');
      print('Remaining: $remaining');
      print('Hr: $hours');
      print('Min: $minutes');
      print('Sec: $seconds');
    } catch (e) {
      print('##getDuration##: $e');
    }
  }

  void getTemperature() {
    try {
      double temp = weatherData['main']['temp'];
      temperature = temp.round()..toInt();
      city = weatherData['name'];
    } catch (e) {
      print('##getTemperature##: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: kCardPadding),
          child: Consumer<PrayerTime>(
            builder: (context, prayerData, child) {
              alarm = prayerData.nextAlarm;
              weatherData = prayerData.weatherData;
              getDuration();
              getTemperature();

              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                      child: Center(
                        child: Text(
                          'COUNTDOWN',
                          style: TextStyle(
                              color: kMetalicGold,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'PoiretOne',
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Container(
                      margin: EdgeInsets.all(10.0),
                      child: CountDownTimer(
                        countdownHrs: hours != null ? hours : '0',
                        countdownMin: minutes != null ? minutes : '0',
                        countdownSec: seconds != null ? seconds : '0',
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 4,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        InfoCard(
                          icon: FontAwesomeIcons.clock,
                          title: alarm != null ? alarm.name : '--',
                          subtitle: alarm != null
                              ? 'in $hours:$minutes hrs'
                              : 'in --:-- hrs',
                        ),
                        SizedBox(width: 10.0),
                        InfoCard(
                          icon: FontAwesomeIcons.thermometerThreeQuarters,
                          title:
                              weatherData != null ? '$temperature°c' : '--°c',
                          subtitle:
                              weatherData != null ? 'Today in $city' : 'Today',
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 2,
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                      padding: EdgeInsets.all(20.0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(30))),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Iftar Alert',
                            style: TextStyle(
                                color: kAmericanGold,
                                fontSize: 25,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.bold),
                          ),
                          CupertinoSwitch(
                              activeColor: kMetalicGold,
                              value: prayerData.iftarAlarmOnOff,
                              onChanged: (bool onOff) {
                                setState(() {
                                  prayerData.iftarAlarmOnOff = onOff;
                                });
                                prayerData.notify();
                              }),
                        ],
                      ),
                    ),
                  ),
                  Expanded(flex: 2, child: Back())
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
