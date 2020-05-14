import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ramadankareem/components/athan_tile.dart';
import 'package:ramadankareem/models/prayer_time.dart';

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
