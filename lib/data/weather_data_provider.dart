import 'dart:convert';

import 'package:http/http.dart' as http;

Future<WeatherInfo> fetchWeatherInfo() async {
  final http.Response res = await http.get('https://jsonkeeper.com/b/OOJE');

  if (res.statusCode == 200) {
    final dynamic body = jsonDecode(res.body);
    return WeatherInfo.fromJson(body);
  } else {
    throw Exception('Failed');
  }
}

class WeatherInfo {
  final List<String> times;
  final List<String> temps;
  final List<String> days;

  WeatherInfo({this.times, this.temps, this.days});

  factory WeatherInfo.fromJson(Map<String , dynamic> json){
    return WeatherInfo(
      times: json['times'].cast<String>(),
      temps: json['temps'].cast<String>(),
      days: json['days'].cast<String>(),
    );
  }
}
