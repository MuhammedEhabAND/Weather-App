import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/services/weather_services.dart';

import '../../models/weather_model.dart';

class WeatherCubit extends Cubit<WeatherState> {

  WeatherService weatherService;
  String? cityName;
  WeatherModel? weatherModel;
  MaterialColor? color;
  WeatherCubit( this.weatherService) : super(WeatherInitial());
  void getWeather({required String cityName})async {
    emit(WeatherLoading());


      try {
        weatherModel = await weatherService.getWeather(cityName: cityName);
        color = weatherModel!.getTheme();
        emit(WeatherSuccess(weatherModel: weatherModel!));
      }on Exception catch(e) {
        emit(WeatherFailure());
      }
  }
}