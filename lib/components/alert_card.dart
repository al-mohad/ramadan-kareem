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
      decoration: BoxDecoration(
        boxShadow: kCardShadow,
      ),
      child: Consumer<PrayerTime>(builder: (context, prayerData, child) {
        return Card(
          shape: kCardShape,
          elevation: 0.0,
          color: Colors.white,
          child: Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: EdgeInsets.only(
                      top: kCardPadding,
                      right: kCardPadding - 5,
                      left: kCardPadding,
                      bottom: kCardPadding),
                  child: Row(
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
                ),
                Container(
                  margin: EdgeInsets.only(left: kCardPadding),
                  child: alarmTitle != null
                      ? Text(
                          alarmTitle,
                          style: TextStyle(
                              fontSize: 40,
                              color: kOldGold,
                              fontWeight: FontWeight.w500),
                        )
                      : SizedBox(),
                ),
                Container(child: alarmBody),
                Container(
                  margin: EdgeInsets.all(kCardPadding),
                  child: Text(
                    cardTitle,
                    style: TextStyle(
                        fontSize: 15.0,
                        color: kOldGold,
                        fontWeight: FontWeight.w500),
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
