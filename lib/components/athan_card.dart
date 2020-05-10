import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ramadankareem/components/athan_tile.dart';
import 'package:ramadankareem/models/prayer_time.dart';
import 'package:ramadankareem/utils/constants.dart';

class Athan extends StatelessWidget {
  final prayerTime;

  Athan({this.prayerTime});

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
                      onChanged: (bool changeAlert) {}),
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

class AthanList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<PrayerTime>(
        builder: (context, prayerData, child) {
          return ListView.builder(
            itemCount: 5,
            padding: EdgeInsets.all(0.0),
            itemBuilder: (context, index) {
              final alarm = prayerData.alarms[index];
              return AthanTile(
                athanTitle: alarm.name,
                isActive: alarm.onOrOff,
                alarmCallback: () {
                  prayerData.updateAlarm(alarm);
                },
              );
            },
          );
        },
      ),
    );
  }
}
