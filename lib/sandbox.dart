//Stack(
//children: [
//Positioned(
//bottom: 70,
//left: 40,
//top: 35,
//child: Icon(
//Icons.keyboard_arrow_up,
//color: Colors.white,
//size: 75,
//),
//),
//Positioned(
//bottom: 85,
//left: 40,
//top: 20,
//child: Icon(
//Icons.keyboard_arrow_up,
//color: kGoldenPoppy.withOpacity(0.5),
//size: 75,
//),
//),
//Positioned(
//top: 90,
//left: 30,
//child: Text(
//'COUNTDOWN',
//style: TextStyle(
//color: Colors.white,
//fontFamily: 'PoiretOne',
//fontWeight: FontWeight.bold,
//fontSize: 14),
//),
//)
//],
//),

/*
stringTimeConverter(String time) {
  // Change a 24hr time string to 12hr format
  // e.g 21:38 to 09:38 pm
  String meridian, newTime;

  time += ' ';
  
  int indexOfColon = time.indexOf(':');
  int hour = int.parse(time.substring(0, indexOfColon));
  int minute = int.parse(time.substring(indexOfColon + 1, indexOfColon + 3));

  // Determine the meridian unit from the hour
  meridian = hour < 12 ? ' am' : ' pm';

  // Change hour to 12hr format if greater than 12
  hour = hour <= 12 ? hour : hour - 12;

  // Put the new hour part in the final string
  newTime = hour < 10 ? '0$hour' : hour.toString();

  // Place the colon after the hour
  newTime += ':';

  // Place the minute part after the colon
  newTime += minute < 10 ? '0$minute' : minute.toString();
  
  // place the meridean unit at the end
  newTime += meridian;

  print('Prayer: $newTime');
  return newTime;
}
*/

/*
fajrToSahur(String fajr) {
  // Format of String fajr = 05:07 (WAT)';
  int indexOfColon = fajr.indexOf(':');
  int hrty = int.parse(fajr.substring(0, indexOfColon));
  int minty = int.parse(fajr.substring(indexOfColon + 1, indexOfColon + 3));

  minty -= 50;
  if (minty.isNegative) {
    hrty = hrty == 0 ? 24 - 1 : hrty - 1;
    minty += 60;
  }

  String n = hrty < 10 ? '0$hrty' : hrty.toString();
  n += ':';
  n += minty < 10 ? '0$minty' : minty.toString();
  // n += hrty < 12 ? ' am' : ' pm';

  print('Fajr: $fajr');
  print('Sahur: $n');
  return n;
}
*/
