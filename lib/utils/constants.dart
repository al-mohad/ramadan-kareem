import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

const kGold = Color(0xffffd700);
const kMetalicGold = Color(0xffd4af37);
const kOldGold = Color(0xffcfb53b);
const kGoldenYellow = Color(0xffffdf00);
const kGoldenPoppy = Color(0xfffcc200);
const kAmericanGold = Color(0xffd3af37);
const kGolden = Color(0xfff5bf03);
const kGoldCoin = Color(0xfffcd975);
const kGoldenCrest = Color(0xfff6ca69);
const kGoldenKiwi = Color(0xfff3dd3e);

const kAPIKEY = '9e9f5d5ff75d1c5db7adb8aeab20d5ff';

const kNextPrayerTileDecoration = BoxDecoration(
  color: kGoldenYellow,
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(15.0),
    bottomRight: Radius.circular(15.0),
  ),
);

const kCardShadow = [
  BoxShadow(
    color: Color(0xFFE0E0E0),
    blurRadius: 30.0,
  )
];

const kCardShape = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(
    Radius.circular(35),
  ),
);

const kCardPadding = 20.0;
