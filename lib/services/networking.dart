import 'dart:convert';

import 'package:http/http.dart' as http;

class NetworkHelper {
  NetworkHelper({this.url});

  final String url;

  Future getData() async {
    try {
      http.Response response = await http.get(url);

      if (response.statusCode == 200) {
        print('getData exited in NetworkHelper');
        return jsonDecode(response.body);
      } else {
        print(response.statusCode);
      }
    } catch (e) {
      print('Problem with the GET request');
      // throw 'Problem with the GET request';
    }
  }
}
