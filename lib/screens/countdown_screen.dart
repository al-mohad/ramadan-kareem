import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:ramadankareem/components/countdown_timer.dart';
import 'package:ramadankareem/utils/constants.dart';

class CountdownScreen extends StatefulWidget {
  @override
  _CountdownScreenState createState() => _CountdownScreenState();
}

class _CountdownScreenState extends State<CountdownScreen> {
  bool onIftarAlert = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          child: Column(
            children: [
              Container(
                margin: EdgeInsets.all(20),
                child: Center(
                  child: Text(
                    'COUNTDOWN',
                    style: TextStyle(
                        color: kMetalicGold,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'PoiretOne',
                        fontSize: 28),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              Expanded(
                  child: CountDownTimer(
                      countdownHrs: '3', countdownMin: '0', countdownSec: '0')),
              SizedBox(height: 10.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 150,
                    width: 150,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(35))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(FontAwesomeIcons.businessTime),
                        Text(
                          'Isha',
                          style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Shine',
                              color: kMetalicGold),
                        ),
                        Text(
                          'in 3:56 hrs',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 150,
                    width: 150,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(35))),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(FontAwesomeIcons.thermometerThreeQuarters),
                        Text(
                          '28oC',
                          style: TextStyle(
                              fontSize: 45,
                              fontWeight: FontWeight.w400,
                              color: kMetalicGold,
                              fontFamily: 'Les'),
                        ),
                        Text(
                          'Today',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10.0),
              Container(
                height: 70,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(30),
                    ),
                  ),
                  child: Container(
                    margin: EdgeInsets.only(left: 25, right: 10),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          'Iftar Alert',
                          style: TextStyle(
                              color: kAmericanGold,
                              fontFamily: 'ShadedLarch',
                              fontSize: 35,
                              fontWeight: FontWeight.bold),
                        ),
                        CupertinoSwitch(
                            activeColor: kMetalicGold,
                            value: onIftarAlert,
                            onChanged: (bool changeAlert) {
                              setState(() {
                                onIftarAlert = !onIftarAlert;
                              });
                            }),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.0),
              BackButton()
            ],
          ),
        ),
      ),
    );
  }
}

class BackButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pop(context),
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
                left: 35,
                top: 45,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                  size: 55,
                ),
              ),
              Positioned(
                bottom: 70,
                left: 15,
                top: 45,
                child: Icon(
                  Icons.arrow_back_ios,
                  color: kGoldenPoppy.withOpacity(0.5),
                  size: 55,
                ),
              ),
              Positioned(
                bottom: 60,
                left: 75,
                top: 60,
                child: Text(
                  'Back',
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontFamily: 'PoiretOne',
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
