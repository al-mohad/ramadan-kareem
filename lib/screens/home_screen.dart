import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:ramadankareem/components/alert_card.dart';
import 'package:ramadankareem/components/athan_list.dart';
import 'package:ramadankareem/components/header.dart';
import 'package:ramadankareem/models/prayer_time.dart';
import 'package:ramadankareem/screens/countdown_screen.dart';
import 'package:ramadankareem/utils/constants.dart';
import 'package:weather_icons/weather_icons.dart';

PrayerTime prayerTime = PrayerTime();

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // getPrayerData();
    prayerTime.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: Container(
        margin: EdgeInsets.all(10.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 2, child: GetHeader()),
            Expanded(flex: 4, child: getBody()),
            Expanded(flex: 1, child: CountdownButton()),
          ],
        ),
      ),
    );
  }

  getBody() => Container(
        child: Consumer<PrayerTime>(
          builder: (context, prayerData, child) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: AlertCard(
                          cardTitle: "Iftar Alert",
                          alertIcon: WeatherIcons.sunrise,
                          alarmOnOff: prayerData.iftarAlarmOnOff,
                          alarmTitle: null,
                          alarmBody: Text(
                            prayerData.iftar != null
                                ? prayerData.iftar
                                : "--:-- pm",
                            style: TextStyle(
                              fontSize: 45,
                              color: kOldGold,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Snowboarding',
                            ),
                          ),
                          alertCallback: (bool onOff) {
                            setState(() {
                              prayerData.iftarAlarmOnOff =
                                  !prayerData.iftarAlarmOnOff;
                            });
                            print('PrayerTime: ${PrayerTime.instance}');
                          },
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Expanded(
                        child: AlertCard(
                          cardTitle: "Sahur Alert",
                          alertIcon: FontAwesomeIcons.solidMoon,
                          alarmOnOff: prayerData.sahurAlarmOnOff,
                          alarmTitle: null,
                          alarmBody: Text(
                            prayerData.sahur != null
                                ? prayerData.sahur
                                : "--:-- pm",
                            style: TextStyle(
                              fontSize: 45,
                              color: kOldGold,
                              fontWeight: FontWeight.w300,
                              fontFamily: 'Snowboarding',
                            ),
                          ),
                          alertCallback: (bool onOff) {
                            setState(() {
                              prayerData.sahurAlarmOnOff =
                                  !prayerData.sahurAlarmOnOff;
                            });
                            print('PrayerTime: ${PrayerTime.instance}');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 5.0),
                Expanded(
                  child: AlertCard(
                    cardTitle: 'Prayer Alert',
                    alertIcon: FontAwesomeIcons.mosque,
                    alarmOnOff: prayerData.sahurAlarmOnOff,
                    alarmTitle: 'Azan',
                    alarmBody: Expanded(
                      child: AthanList(),
                    ),
                    alertCallback: (bool onOff) {
                      setState(() {
                        prayerData.sahurAlarmOnOff =
                            !prayerData.sahurAlarmOnOff;
                      });
                    },
                  ),
                ),
              ],
            );
          },
        ),
      );
}

class CountdownButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => CountdownScreen(),
        ),
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        margin: EdgeInsets.symmetric(vertical: 20, horizontal: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'COUNTDOWN',
              style: TextStyle(
                  fontFamily: 'PoiretOne',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
            Icon(
              Icons.keyboard_arrow_right,
              color: kGoldenPoppy.withOpacity(0.5),
              size: 55,
            ),
            Icon(
              Icons.keyboard_arrow_right,
              color: kGoldenPoppy.withOpacity(0.5),
              size: 55,
            ),
          ],
        ),
      ),
    );
  }
}
