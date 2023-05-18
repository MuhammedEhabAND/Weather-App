import 'dart:convert';

import 'dart:math';

import 'package:flutter/material.dart';

class WeatherModel{
  String location;
  String date;
  double temp;
  double maxTemp;
  double minTemp;
  String condition;
  String icon;

  WeatherModel(
      {required this.location ,
        required this.date,
        required this.temp,
        required this.maxTemp,
        required this.minTemp,
        required this.condition,
        required this .icon});
  factory WeatherModel.fromJson(dynamic data){
    var jsonData = data['forecast']['forecastday'][0]['day'];
    print('$jsonData');
    return WeatherModel(
        location: data['location']['name'],
        date: data['location']['localtime'],
        temp:  jsonData['avgtemp_c'],
        maxTemp:  jsonData['maxtemp_c'],
        minTemp: jsonData['mintemp_c'],
        condition: jsonData['condition']['text'],
        icon: jsonData['condition']['icon']
    );



    }

  MaterialColor getTheme() {

    if(condition=='Clear' || condition == 'Sunny'){
      return Colors.yellow;
    }else if(condition=='Partly cloudy'){
      return Colors.grey;

    }else if(condition=='Cloudy'){
      return Colors.blueGrey;


    }else if(condition=='Overcast') {
      return Colors.blueGrey;
    }else if(condition=='Mist'){
      return Colors.blueGrey;

    }
    else if(condition=='Patchy rain possible') {
      return Colors.orange;
    }
    else if(condition=='Patchy snow possible') {
      return Colors.blue;
    }else if(condition=='Patchy sleet possible') {
      return Colors.grey;
    }else if(condition=='Patchy freezing drizzle possible') {
      return Colors.grey;
    }else if(condition=='Thundery outbreaks possible') {
      return Colors.deepPurple;
    }else if(condition=='Blowing snow') {
      return Colors.grey;
    }else if(condition=='Blizzard') {
      return Colors.grey;
    }else{
      return Colors.grey;}
  }


}