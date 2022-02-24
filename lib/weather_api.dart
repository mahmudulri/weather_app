import 'dart:convert';

import 'package:http/http.dart' as http;
import 'weather_model.dart';

class WeatherApiclient {
  Future<Weather> getCurrentWeather(String? location) async {
    var endpoint = Uri.parse(
        "https://api.openweathermap.org/data/2.5/weather?q=$location&appid=e5056793929c44c1df9851b84fd817ec&units=metric");

    var response = await http.get(endpoint);
    var body = jsonDecode(response.body);
    print(Weather.fromJson(body).cityName);

    return Weather.fromJson(body);
  }
}
