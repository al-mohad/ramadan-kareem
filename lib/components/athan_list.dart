import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ramadankareem/models/alarm.dart';
import 'package:ramadankareem/models/prayer_time.dart';
import 'package:ramadankareem/utils/constants.dart';

class AthanList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final alarms = Provider.of<PrayerTime>(context).alarms;

    // A List of AthanBubble widgets
    List<AthanBubble> athanBubbles = [];

    for (Alarm alarm in alarms) {
      final athanBubble = AthanBubble(
        prayer: alarm.name,
        isNext: alarm.isNext,
        decoration: kNextPrayerTileDecoration,
      );
      athanBubbles.add(athanBubble);
    }
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: athanBubbles,
      ),
    );
  }
}

class AthanBubble extends StatelessWidget {
  AthanBubble({this.prayer, this.isNext, this.decoration});

  final String prayer;
  final bool isNext;
  final BoxDecoration decoration;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
          top: 7.0, right: 7.0, left: kCardPadding, bottom: 7.0),
      decoration: isNext ? decoration : null,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            prayer,
            style: TextStyle(
              fontSize: 18,
              color: kMetalicGold,
              fontWeight: FontWeight.w500,
            ),
          ),
          isNext
              ? Icon(
                  CupertinoIcons.check_mark_circled_solid,
                  color: kMetalicGold,
                  size: 30.0,
                )
              : SizedBox(),
        ],
      ),
    );
  }
}
