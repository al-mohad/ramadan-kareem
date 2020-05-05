import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:ramadankareem/components/header.dart';
import 'package:ramadankareem/models/prayer_time.dart';
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
  String muslimsalat = 'https://muslimsalat.com/kaduna/daily.json?key=$kAPIKEY';
  void getPrayerData() async {
    day = await (DateTime.now().day - 1).toString();
    month = await DateTime.now().month.toString();
    year = await DateTime.now().year.toString();
    String aladhan =
        'http://api.aladhan.com/v1/calendarByCity?city=kaduna&country=Nigeria&method=$day&month=$month&year=$year';

    http.Response response = await http.get(muslimsalat);
    if (response.statusCode == 200) {
      String prayerData = response.body;

      city = jsonDecode(prayerData)['state'];
      country = jsonDecode(prayerData)['country'];
      iftar = jsonDecode(prayerData)['items'][0]['maghrib'];
      print(
          'IFTAR TIME*****************************************************: $country, $iftar');
    } else {
      print(response.statusCode);
    }
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
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          getHeader(),
          Expanded(
            flex: 2,
            child: Container(
              margin: EdgeInsets.all(20.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        IftarAlert(
                          iftarCallback: (bool onOff) {
                            setState(() {
                              iftarAlarmOnOff = !iftarAlarmOnOff;
                            });
                          },
                          iftarAlarmOnOff: iftarAlarmOnOff,
                          iftar: iftar,
                        ),
                        SahurAlert(
                          sahurAlarmOnOff: sahurAlarmOnOff,
                          sahurCallback: (bool onOff) {
                            setState(() {
                              sahurAlarmOnOff = !sahurAlarmOnOff;
                            });
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Azan(prayerTime: prayerTime)
                ],
              ),
            ),
          ),
          CountdownButton(),
        ],
      ),
    );
  }
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

class SahurAlert extends StatelessWidget {
  final bool sahurAlarmOnOff;
  final String sahur;
  final Function sahurCallback;
  SahurAlert({this.sahurAlarmOnOff, this.sahurCallback, this.sahur});

  @override
  Widget build(BuildContext context) {
    return Consumer<PrayerTime>(builder: (context, prayerData, child) {
      final prayer = prayerData.alarms;
      return Expanded(
        flex: 2,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(45))),
          elevation: 1.5,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            FontAwesomeIcons.solidMoon,
                          ),
                          CupertinoSwitch(
                              activeColor: kMetalicGold,
                              value: sahurAlarmOnOff,
                              onChanged: (bool alarm) {
                                prayerData.iftarAlarm;
                              })
                        ],
                      ),
                      Text(
                        '4:00 am',
                        style: TextStyle(
                            fontSize: 45,
                            color: kOldGold,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Snowboarding'),
                      ),
                      Divider(color: kMetalicGold),
                      Container(
                        margin: EdgeInsets.only(bottom: 10),
                        child: Text(
                          'Sahur Alert',
                          style: TextStyle(
                              fontSize: 22,
                              color: kOldGold,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'PoiretOne'),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      );
    });
  }
}

class IftarAlert extends StatelessWidget {
  final bool iftarAlarmOnOff;
  final String iftar;
  final Function iftarCallback;

  IftarAlert({this.iftar, this.iftarCallback, this.iftarAlarmOnOff});
  @override
  Widget build(BuildContext context) {
    return Expanded(
      flex: 2,
      child: Card(
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(45))),
        elevation: 1.5,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                margin: EdgeInsets.only(top: 20, left: 10, right: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(
                          WeatherIcons.sunrise,
                        ),
                        CupertinoSwitch(
                            activeColor: kMetalicGold,
                            value: iftarAlarmOnOff,
                            onChanged: iftarCallback)
                      ],
                    ),
                    Text(
                      '6:49 pm',
                      style: TextStyle(
                          fontSize: 45,
                          color: kOldGold,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Snowboarding'),
                    ),
                    Divider(color: kMetalicGold),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Text(
                        'Iftar Alert',
                        style: TextStyle(
                            fontSize: 22,
                            color: kOldGold,
                            fontWeight: FontWeight.bold,
                            fontFamily: 'PoiretOne'),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class Azan extends StatefulWidget {
  final prayerTime;
  Azan({this.prayerTime});
  @override
  _AzanState createState() => _AzanState();
}

class _AzanState extends State<Azan> {
  bool isAzanOn = true;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(45),
          ),
        ),
        elevation: 3.0,
        color: Colors.white,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(top: 20, left: 15, right: 15, bottom: 5),
              child: Row(
                children: [
                  Icon(
                    FontAwesomeIcons.mosque,
                  ),
                  Spacer(),
                  CupertinoSwitch(
                      activeColor: kMetalicGold,
                      value: isAzanOn,
                      onChanged: (bool changeAlert) {
                        setState(() {
                          isAzanOn = !isAzanOn;
                        });
                      }),
                ],
              ),
            ),
            Center(
              child: Container(
                padding: EdgeInsets.only(left: 10, right: 10),
                child: Text(
                  'Azan',
                  style: TextStyle(
                    fontSize: 40, color: kOldGold,
                    //fontWeight: FontWeight.bold,
                    fontFamily: 'ShadedLarch',
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        //color: kAmericanGold.withAlpha(40),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Fajr',
                              style: TextStyle(
                                fontSize: 30,
                                color: kMetalicGold,
                                fontFamily: 'PoiretOne',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(Icons.check_circle)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        //color: kAmericanGold.withAlpha(40),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Dhuhr',
                              style: TextStyle(
                                fontSize: 30,
                                color: kMetalicGold,
                                fontFamily: 'PoiretOne',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(Icons.check_circle)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        //  color: kAmericanGold.withAlpha(40),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Asr',
                              style: TextStyle(
                                fontSize: 30,
                                fontFamily: 'PoiretOne',
                                color: kMetalicGold,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(Icons.check_circle)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        color: kAmericanGold.withAlpha(40),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Maghrib',
                              style: TextStyle(
                                fontSize: 25,
                                color: kMetalicGold,
                                fontFamily: 'PoiretOne',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(Icons.check_circle)
                          ],
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.symmetric(
                        vertical: 1,
                      ),
                      decoration: BoxDecoration(
                        // color: kAmericanGold.withAlpha(40),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(15),
                          bottomRight: Radius.circular(15),
                        ),
                      ),
                      child: Container(
                        margin:
                            EdgeInsets.symmetric(horizontal: 10, vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Isha',
                              style: TextStyle(
                                fontSize: 30,
                                color: kMetalicGold,
                                fontFamily: 'PoiretOne',
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            Icon(Icons.check_circle)
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Divider(color: kMetalicGold),
            Container(
              margin: EdgeInsets.only(top: 10, bottom: 20, left: 10, right: 10),
              child: Center(
                  child: Text(
                'Prayer Alert',
                style: TextStyle(
                    fontSize: 22,
                    color: kOldGold,
                    fontFamily: 'PoiretOne',
                    fontWeight: FontWeight.bold),
              )),
            ),
          ],
        ),
      ),
    );
  }
}
