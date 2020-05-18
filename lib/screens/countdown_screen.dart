import 'dart:math' as math;

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
  DateTime now, remaining;
  Duration duration;
  String hour, min;
  int temperature;

  void getDuration() {
    try {
      duration = alarm.getDTime.difference(now);
      remaining = DateTime.fromMillisecondsSinceEpoch(duration.inMilliseconds,
          isUtc: true);
      hour = remaining.hour.toString();
      String m = remaining.minute.toString();
      min = m.length < 2 ? '0$m' : m;
    } catch (e) {
      print('##getDuration##: $e');
    }

    print('Alarm: ${alarm.getDTime}');
    print('Duration: $duration');
    print('Remaining: $remaining');
    print('Hr: ${remaining.hour}');
    print('Min: ${remaining.minute}');
    print('Sec: ${remaining.second}');
  }

  void getTemperature() {
    double temp = weatherData['main']['temp'];
    temperature = temp.toInt();
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
              now = DateTime.now();
              getDuration();
              getTemperature();

              return Column(
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
                        countdownHrs: alarm != null ? '${remaining.hour}' : '0',
                        countdownMin:
                            alarm != null ? '${remaining.minute}' : '0',
                        countdownSec:
                            alarm != null ? '${remaining.second}' : '0',
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
                              ? 'in $hour:$min hrs'
                              : 'in --:-- hrs',
                        ),
                        SizedBox(width: 10.0),
                        InfoCard(
                          icon: FontAwesomeIcons.thermometerThreeQuarters,
                          title:
                              weatherData != null ? '$temperature°c' : '--°c',
                          subtitle: 'Today',
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
                                fontSize: 20,
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
