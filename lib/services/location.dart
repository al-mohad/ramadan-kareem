import 'package:geolocator/geolocator.dart';

class Location {
  // singleton_start
  static final Location _location = Location._internal();

  factory Location() {
    instance++;
    return _location;
  }

  Location._internal(); // private constructor

  static int instance = 0;
  // singleton_end

  double latitude;
  double longitude;
  Position _position;

  Future<void> getCurrentLocation() async {
    try {
      _position = await Geolocator()
          .getCurrentPosition(desiredAccuracy: LocationAccuracy.low);
      latitude = _position.latitude;
      longitude = _position.longitude;
      print('getCurrentLocation exited');
    } catch (e) {
      throw 'Problem with the location request';
    }
  }
}
