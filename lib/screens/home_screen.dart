import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:ramadankareem/components/alert_card.dart';
import 'package:ramadankareem/components/athan_card.dart';
import 'package:ramadankareem/components/header.dart';
import 'package:ramadankareem/screens/countdown_screen.dart';
import 'package:ramadankareem/utils/constants.dart';
import 'package:weather_icons/weather_icons.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String city;
  String country;
  var prayerTime;
  List<String> prayers;
  String day;
  String month;
  String year;
  String iftar;
  String fajr;
  String muslimsalat = 'https://muslimsalat.com/kaduna/daily.json?key=$kAPIKEY';
  void getPrayerData() async {
    day = (DateTime.now().day - 1).toString();
    month = DateTime.now().month.toString();
    year = DateTime.now().year.toString();
    String aladhan =
        'http://api.aladhan.com/v1/calendarByCity?city=kaduna&country=Nigeria&method=$day&month=$month&year=$year';

    http.Response response = await http.get(muslimsalat);
    if (response.statusCode == 200) {
      String prayerData = response.body;

      city = jsonDecode(prayerData)['state'];
      country = jsonDecode(prayerData)['country'];
      iftar = jsonDecode(prayerData)['items'][0]['maghrib'];
      fajr = jsonDecode(prayerData)['items'][0]['fajr'];
      setState(() {
        fajr = stringToTime(fajr);
      });
      print(
          'IFTAR TIME*****************************************************: $country, $iftar');
    } else {
      print(response.statusCode);
    }
  }

  stringToTime(String fajr) {
    String i = '4:14 am';

    int indexOfColon = fajr.indexOf(':');
    int hrty = int.parse(fajr.substring(0, indexOfColon));
    print('hrty: $hrty');
    int minty = int.parse(fajr.substring(indexOfColon + 1, indexOfColon + 2));
    minty -= 5;
    print('minty: $minty');

    if (minty.isNegative) {
      hrty -= 1;
      minty += 6;
    }
    print('new  hrty: $hrty');
    print('new minty: $minty');

    String n = hrty.toString();
    n += fajr.substring(indexOfColon, indexOfColon + 1);
    n += minty.toString();
    n += fajr.substring(indexOfColon + 2, i.length);

    print('fajr: $fajr');
    print('Sahur Alert: $n');
    return n;
  }

  getLocation() async {
    try {
      Position position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      print(position);
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    getPrayerData();
    getLocation();
  }

  bool iftarAlarmOnOff = true;
  bool sahurAlarmOnOff = true;
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

  getBody() => Row(
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
                    alarmOnOff: iftarAlarmOnOff,
                    alarmTitle: null,
                    alarmBody: Text(
                      iftar != null ? iftar : "--:-- pm",
                      style: TextStyle(
                        fontSize: 45,
                        color: kOldGold,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Snowboarding',
                      ),
                    ),
                    alertCallback: (bool onOff) {
                      setState(() {
                        iftarAlarmOnOff = !iftarAlarmOnOff;
                      });
                    },
                  ),
                ),
                SizedBox(height: 5.0),
                Expanded(
                  child: AlertCard(
                    cardTitle: "Sahur Alert",
                    alertIcon: FontAwesomeIcons.solidMoon,
                    alarmOnOff: sahurAlarmOnOff,
                    alarmTitle: null,
                    alarmBody: Text(
                      fajr != null ? fajr : "--:-- pm",
                      style: TextStyle(
                        fontSize: 45,
                        color: kOldGold,
                        fontWeight: FontWeight.w300,
                        fontFamily: 'Snowboarding',
                      ),
                    ),
                    alertCallback: (bool onOff) {
                      setState(() {
                        sahurAlarmOnOff = !sahurAlarmOnOff;
                      });
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
              alarmOnOff: sahurAlarmOnOff,
              alarmTitle: 'Azan',
              alarmBody: Expanded(
                child: AthanList(),
              ),
              alertCallback: (bool onOff) {
                setState(() {
                  sahurAlarmOnOff = !sahurAlarmOnOff;
                });
              },
            ),
          ),
        ],
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
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          color: kMetalicGold,
          borderRadius: BorderRadius.all(
            Radius.circular(80),
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              Positioned(
                bottom: 70,
                left: 40,
                top: 35,
                child: Icon(
                  Icons.keyboard_arrow_up,
                  color: Colors.white,
                  size: 75,
                ),
              ),
              Positioned(
                bottom: 85,
                left: 40,
                top: 20,
                child: Icon(
                  Icons.keyboard_arrow_up,
                  color: kGoldenPoppy.withOpacity(0.5),
                  size: 75,
                ),
              ),
              Positioned(
                top: 90,
                left: 30,
                child: Text(
                  'COUNTDOWN',
                  style: TextStyle(
                      color: Colors.white,
                      fontFamily: 'PoiretOne',
                      fontWeight: FontWeight.bold,
                      fontSize: 14),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
