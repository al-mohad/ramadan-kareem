import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:ramadankareem/utils/constants.dart';

class getHeader extends StatelessWidget {
  const getHeader({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        margin:
            EdgeInsets.only(top: 50.0, left: 20.0, right: 20.0, bottom: 20.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Positioned(
                    bottom: 55,
                    child: Text(
                      'Ramadan',
                      style: TextStyle(
                          fontSize: 90,
                          fontWeight: FontWeight.w400,
                          fontFamily: 'Snowboarding',
                          color: kMetalicGold),
                    ),
                  ),
                  Positioned(
                    top: 45,
                    right: 30,
                    child: Text(
                      'Kareem',
                      style: TextStyle(
                          fontSize: 90,
                          fontWeight: FontWeight.w300,
                          fontFamily: 'Snowboarding',
                          color: kMetalicGold),
                    ),
                  ),
                ],
              ),
            ),
            Image.asset(
              'images/1.png',
              filterQuality: FilterQuality.high,
            )
          ],
        ),
      ),
    );
  }
}
