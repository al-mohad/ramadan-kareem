import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ramadankareem/utils/constants.dart';

class Back extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 10.0),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(30))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.keyboard_arrow_left,
              color: kGoldenPoppy.withOpacity(0.5),
              size: 55,
            ),
            Icon(
              Icons.keyboard_arrow_left,
              color: kGoldenPoppy.withOpacity(0.5),
              size: 55,
            ),
            Text(
              'BACK',
              style: TextStyle(
                  fontFamily: 'PoiretOne',
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
