import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ramadankareem/utils/constants.dart';

class InfoCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  InfoCard({this.icon, this.title, this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin:
            EdgeInsets.only(top: 10.0, right: 10.0, left: 10.0, bottom: 20.0),
        padding: EdgeInsets.all(20.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              icon,
              size: 25,
            ),
            SizedBox(height: 20.0),
            Text(
              title,
              style: TextStyle(
                  fontSize: 30,
                  color: kMetalicGold,
                  fontWeight: FontWeight.w500),
            ),
            Text(
              subtitle,
              style: TextStyle(
                color: Colors.grey,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
