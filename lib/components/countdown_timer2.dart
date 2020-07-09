import 'dart:math' as math;

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ramadankareem/models/alarm.dart';
import 'package:ramadankareem/notifiers/alarm_notifier.dart';
import 'package:ramadankareem/utils/constants.dart';

class CountDownTimer2 extends StatefulWidget {
  final String countdownSec, countdownMin, countdownHrs;
  CountDownTimer2({this.countdownHrs, this.countdownMin, this.countdownSec});
  @override
  _CountDownTimer2State createState() => _CountDownTimer2State();
}

class _CountDownTimer2State extends State<CountDownTimer2>
    with TickerProviderStateMixin {
  AnimationController controller;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${(duration.inHours % 12).toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}:${(duration.inMilliseconds % 1000).toString().padLeft(2, '0')}';
  }

  startTimer() {
    if (controller.isAnimating)
      controller.stop();
    else {
      controller.reverse(
          from: controller.value == 0.0 ? 1.0 : controller.value);
    }
  }

  @override
  void initState() {
    // Timer.periodic(Duration(seconds: 1), (timer) {
    //   setState(() {});
    // });
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(
        hours: int.parse(widget.countdownHrs),
        minutes: int.parse(widget.countdownMin),
        seconds: int.parse(widget.countdownSec),
      ),
    );
    startTimer();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Alarm alarm = Provider.of<AlarmNotifier>(context).nextAlarm;
    return Container(
      alignment: Alignment.center,
      child: AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(15.0),
            width: MediaQuery.of(context).size.width * 0.8,
            height: MediaQuery.of(context).size.width * 0.8,
            decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Color(0xFFE1E1E1),
                    offset: Offset(5, 20),
                    blurRadius: 40.0,
                    spreadRadius: 40.0,
                  )
                ]),
            child: Stack(
              children: <Widget>[
                Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.width,
                  child: Transform(
                    transform: Matrix4.identity()..rotateY(-0.01 * 300),
                    alignment: FractionalOffset.center,
                    child: Transform.rotate(
                      angle: -1.56,
                      child: CustomPaint(
                        painter: ClockPainter(animController: controller),
                      ),
                    ),
                  ),
                ),
                Container(
                    child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(
                        Icons.wb_sunny,
                        size: 30,
                        color: kGoldenPoppy,
                      ),
                      SizedBox(height: 10.0),
                      Text(
                        timerString,
                        style: TextStyle(
                            color: kMetalicGold,
                            fontSize: 25.0,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'mins remaining',
                        style: TextStyle(
                            letterSpacing: 0.5,
                            fontSize: 15.0,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey),
                      ),
                      RichText(
                        text: TextSpan(
                            text: 'for ',
                            style: TextStyle(
                                letterSpacing: 0.5,
                                fontSize: 15.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.grey),
                            children: [
                              TextSpan(
                                text: '${alarm != null ? alarm.name : ''}',
                                style: TextStyle(
                                    letterSpacing: 0.5,
                                    fontSize: 18.0,
                                    fontWeight: FontWeight.bold,
                                    color: kMetalicGold),
                              ),
                            ]),
                      ),
                    ],
                  ),
                )),
              ],
            ),
          );
        },
      ),
    );
  }
}

class ClockPainter extends CustomPainter {
  playSound() {
    final player = AudioCache();
    player.play('sounds/bell.mp3');
  }

  ClockPainter({
    this.animController,
  }) : super(repaint: animController);

  final AnimationController animController;
  //60 sec - 360, 1 sec - 6degrees
  //12 hours - 360, 1 hour - 30degrees, 1 min - 0.5degrees

  @override
  void paint(Canvas canvas, Size size) {
    double initial, now, progress;

    var centerX = size.width / 2;
    var centerY = size.height / 2;
    var radius = math.min(centerX, centerY);

    var dashBrush = Paint()
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 3;

    var longDashRadiusStart = radius;
    var longDashRadiusEnd = radius - 24;

    var shortDashRadiusStart = radius - 12;
    var shortDashRadiusEnd = radius - 24;

    initial = animController.duration.inMilliseconds.toDouble() / 1000;

    for (double i = 0; i <= 360; i += 8) {
      now = initial * animController.value;

      // int progress = ((initial - now) / 1.33).floor(); // find constant value
      // progress *= 4; // find constant value

      progress = initial - now;
      double factor = initial / 45;
      double angle = (progress / factor) * 8;
      // print(
      //     'Initial: $initial, now: $now, I: $i, Angle: $angle, Progress: $progress');
      if (i > angle) {
        var xL1 = centerX + longDashRadiusStart * math.cos(i * math.pi / 180);
        var yL1 = centerX + longDashRadiusStart * math.sin(i * math.pi / 180);

        var xL2 = centerX + longDashRadiusEnd * math.cos(i * math.pi / 180);
        var yL2 = centerX + longDashRadiusEnd * math.sin(i * math.pi / 180);

        canvas.drawLine(Offset(xL1, yL1), Offset(xL2, yL2),
            dashBrush..color = kMetalicGold);
      } else {
        var xS1 = centerX + shortDashRadiusStart * math.cos(i * math.pi / 180);
        var yS1 = centerX + shortDashRadiusStart * math.sin(i * math.pi / 180);

        var xS2 = centerX + shortDashRadiusEnd * math.cos(i * math.pi / 180);
        var yS2 = centerX + shortDashRadiusEnd * math.sin(i * math.pi / 180);

        canvas.drawLine(
            Offset(xS1, yS1), Offset(xS2, yS2), dashBrush..color = kGolden);
      }
    }

    if (progress == initial) {
      print('done');
      playSound();
    }
  }

  @override
  bool shouldRepaint(ClockPainter oldDelegate) {
    return animController.value != oldDelegate.animController.value;
  }
}
