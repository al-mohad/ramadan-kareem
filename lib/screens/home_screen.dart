import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ramadankareem/api/alarm_api.dart';
import 'package:ramadankareem/components/alert_card.dart';
import 'package:ramadankareem/components/athan_list.dart';
import 'package:ramadankareem/components/header.dart';
import 'package:ramadankareem/notifiers/alarm_notifier.dart';
import 'package:ramadankareem/screens/countdown_screen.dart';
import 'package:ramadankareem/services/location.dart';
import 'package:ramadankareem/services/weather.dart';
import 'package:ramadankareem/utils/constants.dart';
import 'package:weather_icons/weather_icons.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    start();
  }

  void start() async {
    AlarmNotifier alarmNotifier =
        Provider.of<AlarmNotifier>(context, listen: false);
    await Location().getCurrentLocation();
    await WeatherModel().getLocationWeather();
    getCalenderDataByCity(alarmNotifier);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFf6f7f9),
      body: Container(
        margin: EdgeInsets.all(kCardPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(flex: 2, child: GetHeader()),
            Expanded(flex: 4, child: getBody()),
            Expanded(flex: 1, child: getFooter()),
          ],
        ),
      ),
    );
  }

  getBody() => Container(
        margin: EdgeInsets.symmetric(horizontal: 5.0),
        child: Consumer<AlarmNotifier>(
          builder: (context, notifier, child) {
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
                          alarmOnOff: notifier.iftar.isNext,
                          alarmTitle: null,
                          alarmBody: Container(
                            padding: EdgeInsets.only(left: kCardPadding),
                            child: Text(
                              notifier.iftar.getSTime != null
                                  ? notifier.iftar.getSTime
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
                              notifier.iftar.toggleNextAlarm(onOff);
                            });
                            notifier.notify();
                            print('Iftar Time: ${notifier.iftar.getDTime}');
                          },
                        ),
                      ),
                      Expanded(
                        child: AlertCard(
                          cardTitle: "Sahur Alert",
                          alertIcon: FontAwesomeIcons.solidMoon,
                          alarmOnOff: notifier.sahur.isNext,
                          alarmTitle: null,
                          alarmBody: Container(
                            padding: EdgeInsets.only(left: kCardPadding),
                            child: Text(
                              notifier.sahur.getSTime != null
                                  ? notifier.sahur.getSTime
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
                              notifier.sahur.toggleNextAlarm(onOff);
                            });
                            print('Sahur Time: ${notifier.sahur.getDTime}');
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
                    alarmOnOff: notifier.prayerAlarmOnOff,
                    alarmTitle: 'Azan',
                    alarmBody: AthanList(),
                    alertCallback: (bool onOff) {
                      setState(() {
                        notifier.prayerAlarmOnOff = onOff;
                      });
                      print('Prayer Alarm: ${notifier.prayerAlarmOnOff}');
                    },
                  ),
                ),
              ],
            );
          },
        ),
      );

  getFooter() => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Container(
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                child: FlatButton.icon(
                  onPressed: () => this.start(),
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
