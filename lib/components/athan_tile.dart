import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ramadankareem/utils/constants.dart';

class AthanTile extends StatelessWidget {
  final String athanTitle;
  final bool isActive;
  final Function alarmCallback;

  const AthanTile({this.athanTitle, this.isActive, this.alarmCallback});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        athanTitle,
        style: TextStyle(
          fontSize: 25,
          color: kMetalicGold,
          fontFamily: 'PoiretOne',
          fontWeight: FontWeight.w600,
        ),
      ),
      contentPadding: EdgeInsets.symmetric(horizontal: 0.0),
      trailing: isActive
          ? Icon(
              Icons.check_circle,
              color: kMetalicGold,
            )
          : SizedBox(),
      onTap: alarmCallback,
    );
  }
}
