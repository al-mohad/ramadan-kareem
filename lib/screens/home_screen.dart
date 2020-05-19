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
    prayerTime.getStarted();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade300,
      body: Container(
        margin: EdgeInsets.all(kCardPadding),
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
        margin: EdgeInsets.symmetric(horizontal: 5.0),
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
                                  : "--:--",
                              style: TextStyle(
                                letterSpacing: -3,
                                fontSize: 40,
                                color: kOldGold,
                                fontFamily: 'Raleway',
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          alertCallback: (bool onOff) {
                            setState(() {
                              prayerData.iftarAlarmOnOff = onOff;
                            });
                            prayerData.notify();
                            print(
                                'Magrib Time: ${prayerData.alarms[3].getDTime}');
                          },
                        ),
                      ),
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
                                  : "--:--",
                              style: TextStyle(
                                letterSpacing: -3,
                                fontSize: 40,
                                color: kOldGold,
                                fontFamily: 'Raleway',
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
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Container(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: FlatButton.icon(
                onPressed: () => prayerTime.getStarted(),
                icon: Icon(
                  Icons.refresh,
                  color: kMetalicGold,
                  size: 20,
                ),
                label: Text(
                  'Refresh',
                  style: TextStyle(
                      color: kMetalicGold,
                      fontFamily: 'Raleway',
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Container(
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: FlatButton.icon(
                onPressed: () => Navigator.push(
                  context,
                  CupertinoPageRoute(
                    builder: (_) => CountdownScreen(),
                  ),
                ),
                icon: Icon(
                  Icons.arrow_forward_ios,
                  color: kMetalicGold,
                  size: 14,
                ),
                label: Text(
                  'COUNTDOWN',
                  style: TextStyle(
                      color: kMetalicGold,
                      fontFamily: 'Raleway',
                      fontSize: 14,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
