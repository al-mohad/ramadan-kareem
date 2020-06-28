import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

BoxDecoration kNextPrayerTileDecoration = BoxDecoration(
  color: kGoldenYellow.withAlpha(80),
  borderRadius: BorderRadius.only(
    topRight: Radius.circular(15.0),
    bottomRight: Radius.circular(15.0),
  ),
);

const kCardShadow = [
  BoxShadow(
    color: Color(0xFFE1E1E1),
    offset: Offset(15, 20),
    blurRadius: 40.0,
    spreadRadius: 40.0,
  ),
];

const kCardShape = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(
    Radius.circular(35),
  ),
);

const kCardPadding = 20.0;

http.Response dummyWeather = http.Response(
  '{"coord":{"lon":7.46,"lat":10.52},"weather":[{"id":804,"main":"Clouds","description":"overcast clouds","icon":"04d"}],"base":"stations","main":{"temp":66.33,"feels_like":34.64,"temp_min":33.66,"temp_max":33.66,"pressure":1010,"humidity":44,"sea_level":1010,"grnd_level":946},"wind":{"speed":3.67,"deg":243},"clouds":{"all":99},"dt":1589892973,"sys":{"country":"NG","sunrise":1589864868,"sunset":1589910346},"timezone":3600,"id":2335727,"name":"Kaduna","cod":200}',
  200,
);

http.Response dummyTime = http.Response(
  '',
  200,
);
