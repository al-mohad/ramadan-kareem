import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ramadankareem/models/alarm.dart';
import 'package:ramadankareem/notifiers/alarm_notifier.dart';
import 'package:ramadankareem/utils/constants.dart';

class CountDownTimer extends StatefulWidget {
  final String countdownSec, countdownMin, countdownHrs;
  CountDownTimer({this.countdownHrs, this.countdownMin, this.countdownSec});
  @override
  _CountDownTimerState createState() => _CountDownTimerState();
}

class _CountDownTimerState extends State<CountDownTimer>
    with TickerProviderStateMixin {
  AnimationController controller;

  String get timerString {
    Duration duration = controller.duration * controller.value;
    return '${(duration.inHours % 12).toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${(duration.inSeconds % 60).toString().padLeft(2, '0')}';
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
    super.initState();
    controller = AnimationController(
      vsync: this,
      duration: Duration(
          hours: int.parse(widget.countdownHrs),
          minutes: int.parse(widget.countdownMin),
          seconds: int.parse(widget.countdownSec)),
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
    return Scaffold(
      backgroundColor: Colors.white10,
      body: AnimatedBuilder(
          animation: controller,
          builder: (context, child) {
            return Stack(
              children: <Widget>[
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    height:
                        controller.value * MediaQuery.of(context).size.height,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Expanded(
                        child: Align(
                          alignment: FractionalOffset.center,
                          child: AspectRatio(
                            aspectRatio: 1.0,
                            child: Stack(
                              children: <Widget>[
                                Container(
                                    child: Center(
                                  child: Stack(
                                    children: [
                                      Positioned(
                                        top: 80,
                                        left: 50,
                                        child: Center(
                                          child: Text(
                                            timerString,
                                            style: TextStyle(
                                                fontSize: 70.0,
                                                fontFamily: 'Snowboarding',
                                                color: kMetalicGold),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        bottom: 90,
                                        left: 30,
                                        child: Center(
                                          child: Text(
                                            "Remaining for ${alarm != null ? alarm.name : ''}",
                                            softWrap: true,
                                            textAlign: TextAlign.center,
                                            textWidthBasis:
                                                TextWidthBasis.parent,
                                            style: TextStyle(
                                              fontSize: 40.0,
                                              fontFamily: 'Snowboarding',
                                              color: kMetalicGold,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                )),
                                Positioned.fill(
                                  child: CustomPaint(
                                    painter: CustomTimerPainter(
                                      animation: controller,
                                      backgroundColor: kGold,
                                      color: kMetalicGold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
//                      AnimatedBuilder(
//                          animation: controller,
//                          builder: (context, child) {
//                            return FloatingActionButton.extended(
//                                onPressed: () {
//                                  if (controller.isAnimating)
//                                    controller.stop();
//                                  else {
//                                    controller.reverse(
//                                        from: controller.value == 0.0
//                                            ? 1.0
//                                            : controller.value);
//                                  }
//                                },
//                                icon: Icon(controller.isAnimating
//                                    ? Icons.pause
//                                    : Icons.play_arrow),
//                                label: Text(
//                                    controller.isAnimating ? "Pause" : "Play"));
//                          }),
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}

class CustomTimerPainter extends CustomPainter {
  CustomTimerPainter({
    this.animation,
    this.backgroundColor,
    this.color,
  }) : super(repaint: animation);

  final Animation<double> animation;
  final Color backgroundColor, color;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = backgroundColor
      ..strokeWidth = 10.0
      ..strokeCap = StrokeCap.butt
      ..style = PaintingStyle.stroke;

    canvas.drawCircle(size.center(Offset.zero), size.width / 2.0, paint);
    paint.color = color;
    double progress = (1.0 - animation.value) * 2 * math.pi;
    canvas.drawArc(Offset.zero & size, math.pi * 1.5, -progress, false, paint);
  }

  @override
  bool shouldRepaint(CustomTimerPainter old) {
    return animation.value != old.animation.value ||
        color != old.color ||
        backgroundColor != old.backgroundColor;
  }
}
