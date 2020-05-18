import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ramadankareem/models/prayer_time.dart';
import 'package:ramadankareem/screens/home_screen.dart';
import 'package:ramadankareem/utils/constants.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => PrayerTime(),
      child: MaterialApp(
        title: 'Ramadan Kareem',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
          accentColor: kMetalicGold,
          primaryColor: kMetalicGold,
          iconTheme: IconThemeData(color: kMetalicGold),
          cupertinoOverrideTheme:
              CupertinoThemeData(primaryColor: kMetalicGold),
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ).copyWith(),
        home: HomeScreen(),
      ),
    );
  }
}
