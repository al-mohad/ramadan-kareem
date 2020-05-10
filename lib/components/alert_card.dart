import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ramadankareem/models/prayer_time.dart';
import 'package:ramadankareem/utils/constants.dart';

class AlertCard extends StatelessWidget {
  final String cardTitle;
  final IconData alertIcon;
  final bool alarmOnOff;
  final String alarmTitle;
  final Widget alarmBody;
  final Function alertCallback;

  AlertCard({
    this.cardTitle,
    this.alertIcon,
    this.alarmOnOff,
    this.alarmTitle,
    this.alarmBody,
    this.alertCallback,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Consumer<PrayerTime>(builder: (context, prayerData, child) {
        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(45),
            ),
          ),
          elevation: 1.5,
          color: Colors.white,
          child: Container(
            margin: EdgeInsets.all(15.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Icon(
                      alertIcon,
                    ),
                    CupertinoSwitch(
                      activeColor: kMetalicGold,
                      value: alarmOnOff,
                      onChanged: alertCallback,
                    )
                  ],
                ),
                alarmTitle != null
                    ? Text(
                        alarmTitle,
                        style: TextStyle(
                            fontSize: 40,
                            color: kOldGold,
                            fontFamily: 'ShadedLarch'),
                      )
                    : SizedBox(),
                Container(child: alarmBody),
                Divider(color: kMetalicGold),
                Container(
                  child: Text(
                    cardTitle,
                    style: TextStyle(
                        fontSize: 22.0,
                        color: kOldGold,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PoiretOne'),
                  ),
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
