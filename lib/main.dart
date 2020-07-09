import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:ramadankareem/notifiers/alarm_notifier.dart';
import 'package:ramadankareem/screens/home_screen.dart';
import 'package:ramadankareem/utils/constants.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => AlarmNotifier(),
    ),
  ], child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      title: 'Ramadan Kareem',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: kMetalicGold,
        primaryColor: kMetalicGold,
        iconTheme: IconThemeData(color: kMetalicGold),
        cupertinoOverrideTheme: CupertinoThemeData(primaryColor: kMetalicGold),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ).copyWith(),
      home: HomeScreen(),
    );
  }
}
