import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/services/weather_services.dart';
import 'package:get/get.dart';
class SearchPage extends StatelessWidget {
  String? cityName;
  static String id ='Search Page';
  @override
  Widget build(BuildContext context) {
    return   Scaffold(
        appBar: AppBar(
          title: Text(
            'Search a city'
          ),

        ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0 , vertical: 180),
              child: TextField(
                onChanged: (data){
                  cityName = data;
                },
                onSubmitted: (data){
                  cityName = data;
                  BlocProvider.of<WeatherCubit>(context).cityName = cityName;
                  BlocProvider.of<WeatherCubit>(context).getWeather(cityName: cityName!);
                  Navigator.pop(context);
                },
                decoration: InputDecoration(
                  labelText: 'Search',
                  hintText: 'Enter a city ',
                  suffix: GestureDetector(
                      onTap: (){
                        BlocProvider.of<WeatherCubit>(context).cityName = cityName;
                        BlocProvider.of<WeatherCubit>(context).getWeather(cityName: cityName!);
                        Navigator.pop(context);

                      },
                      child: Icon(Icons.search)),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ],
        ),
      ),

    ) ;

  }
}