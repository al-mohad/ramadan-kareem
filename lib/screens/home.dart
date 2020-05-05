import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';
import 'package:ramadankareem/utils/constants.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  getLocation() async {
    Position position = await Geolocator().getCurrentPosition(
        desiredAccuracy: LocationAccuracy.bestForNavigation);
    print('The Location Latitude: $position');
  }

  String prayerTimeByCity =
      'https://muslimsalat.com/kaduna/daily.json?key=$kAPIKEY';
  void getPrayerData() async {
    Response response = await get(prayerTimeByCity);
    print(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FlatButton(
          onPressed: () => getPrayerData(),
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
