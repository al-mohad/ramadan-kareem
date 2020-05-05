import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ramadankareem/screens/countdown_screen.dart';

class CountdownButton extends StatelessWidget {
  const CountdownButton({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        CupertinoPageRoute(
          builder: (_) => CountdownScreen(),
        ),
      ),
      child: Container(
        height: 150,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(
            Radius.circular(80),
          ),
        ),
        child: Center(
          child: Stack(
            children: [
              Icon(
                Icons.arrow_drop_up,
                color: Colors.white,
                size: 75,
              ),
              Text(
                'Countdown',
                style: TextStyle(color: Colors.white),
              )
            ],
          ),
        ),
      ),
    );
  }
}
