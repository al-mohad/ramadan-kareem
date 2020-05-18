import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
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
    prayerTime.getLocation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
        margin: EdgeInsets.symmetric(horizontal: 15.0),
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
                          alarmBody: Container(
                            padding: EdgeInsets.only(left: kCardPadding),
                            child: Text(
                              prayerData.alarms[3].getSTime != null
                                  ? prayerData.alarms[3].getSTime
                                  : "18:28",
                              style: TextStyle(
                                letterSpacing: -3,
                                fontSize: 40,
                                color: kOldGold,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          alertCallback: (bool onOff) {
                            setState(() {
                              prayerData.iftarAlarmOnOff = onOff;
                            });
                            print(
                                'Magrib Time: ${prayerData.alarms[3].getDTime}');
                          },
                        ),
                      ),
                      SizedBox(height: 15.0),
                      Expanded(
                        child: AlertCard(
                          cardTitle: "Sahur Alert",
                          alertIcon: FontAwesomeIcons.solidMoon,
                          alarmOnOff: prayerData.sahurAlarmOnOff,
                          alarmTitle: null,
                          alarmBody: Container(
                            padding: EdgeInsets.only(left: kCardPadding),
                            child: Text(
                              prayerData.sahur != null
                                  ? prayerData.sahur
                                  : "4:10",
                              style: TextStyle(
                                letterSpacing: -3,
                                fontSize: 40,
                                color: kOldGold,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          alertCallback: (bool onOff) {
                            setState(() {
                              prayerData.sahurAlarmOnOff = onOff;
                            });
                            print(
                                'Fajr Time: ${prayerData.alarms[0].getDTime}');
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15.0),
                Expanded(
                  child: AlertCard(
                    cardTitle: 'Prayer Alert',
                    alertIcon: FontAwesomeIcons.mosque,
                    alarmOnOff: prayerData.prayerAlarmOnOff,
                    alarmTitle: 'Azan',
                    alarmBody: AthanList(),
                    alertCallback: (bool onOff) {
                      setState(() {
                        prayerData.prayerAlarmOnOff = onOff;
                      });
                      print('Prayer Alarm: ${prayerData.prayerAlarmOnOff}');
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
