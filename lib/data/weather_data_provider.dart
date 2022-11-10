import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/constants/urls.dart';
import 'package:weather_app/utils/string_to_uri.dart';

Future<WeatherInfo> fetchWeatherInfo(String param) async {
  final url = "${ApiEndpoints.url}$param";

  final http.Response res = await http.get(stringToUri(url));

  if (res.statusCode == 200) {
    final body = jsonDecode(res.body);
    print(body);
    return WeatherInfo.fromJson(body);
  } else {
    throw Exception('Failed');
  }
}

class WeatherInfo {
  late final String city;
  late final String country;
  late final double temperature;
  late final String text;
  late final String icon;

  WeatherInfo(
      {required this.temperature, required this.text, required this.icon});

  WeatherInfo.fromJson(Map json) {
    city = json["location"]["name"] ?? "";
    country = json["location"]["country"] ?? "";
    temperature = json["current"]["temp_c"] ?? 0;
    text = json["current"]["condition"]["text"] ?? "";
    icon = json["current"]["condition"]["icon"] ?? "";
  }
}
