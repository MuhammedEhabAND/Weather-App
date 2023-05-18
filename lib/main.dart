import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:weather_app/cubits/weather_cubit/weather_cubit.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/screens/homePage.dart';
import 'package:weather_app/screens/searchPage.dart';
import 'package:weather_app/services/weather_services.dart';

import 'cubits/weather_cubit/weather_state.dart';

void main() {
  runApp(
      BlocProvider(create: (context) {
        return WeatherCubit(WeatherService());
      },
      child:WeatherApp(),));
}
class WeatherApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WeatherCubit, WeatherState>(builder: (context, state) {
      var primarySwatch = Colors.blue;
      if (state is WeatherSuccess) {
        primarySwatch = state.weatherModel!.getTheme();
      }

      return MaterialApp(
          routes: {
            HomePage.id: (context) => HomePage(),
            SearchPage.id: (context) => SearchPage(),
          },
          initialRoute: HomePage.id,
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              primarySwatch: primarySwatch),
          home: HomePage());
    });
  }
}
