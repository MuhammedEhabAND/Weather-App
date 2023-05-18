import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:weather_app/models/weather_model.dart';
class WeatherService{
  Future<WeatherModel> getWeather({required String cityName }) async{
    String baseUrl = 'http://api.weatherapi.com/v1';
    String key = '0cac7782b0fc4adc9c970757232604';
    Uri url = Uri.parse('$baseUrl/forecast.json?key=$key&q=$cityName&days=1');
    http.Response response = await http.get(url);
    Map<String, dynamic> data ;
   if(response.statusCode==200) {
    data = jsonDecode(response.body);

   }else{
     throw Exception('there is a problem with statues code ${response.statusCode}');

   }
    WeatherModel weather = WeatherModel.fromJson(data);
    return weather;


  }
}