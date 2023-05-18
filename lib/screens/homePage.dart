import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:weather_app/cubits/weather_cubit/weather_state.dart';
import 'package:weather_app/models/weather_model.dart';
import 'package:weather_app/screens/searchPage.dart';
import 'package:get/get.dart';

import '../cubits/weather_cubit/weather_cubit.dart';


class HomePage extends StatelessWidget {
  HomePage();
  static String id = 'Home Page';
  WeatherModel? weatherData ;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            'Weather App'
          ),
          actions: [
            IconButton(onPressed: (){
              Navigator.pushNamed(context, SearchPage.id);
              }, icon: Icon(Icons.search)),
          ],
        ),
        body: BlocBuilder<WeatherCubit ,WeatherState>(builder: (context , state){
            if(state is WeatherLoading){
              return Center(
                child: CircularProgressIndicator(),
              );
            }else if (state is WeatherSuccess){

              return BodySuccess(weatherData: state.weatherModel);

            }else if (state is WeatherFailure){
              return Center(child :Text('Something went wrong , please try again '));
            }else {
              return
                BodyDefault();
            }
           },
        ),
    );
    }
}

class BodyDefault extends StatelessWidget {
  const BodyDefault({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'there is no weather 😔 start',
              style: TextStyle(
                fontSize: 30,
              ),
            ),
            Text(
              'searching now 🔍',
              style: TextStyle(
                fontSize: 30,
              ),
            )
          ],
        ));
  }
}

class BodySuccess extends StatelessWidget {
   BodySuccess({
    required this.weatherData,
  });

   WeatherModel? weatherData;

  @override
  Widget build(BuildContext context) {
    return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                weatherData!.getTheme(),
                weatherData!.getTheme()[300]!,
                weatherData!.getTheme()[100]!,

              ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
            )
          ),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Spacer(flex: 3,),
              Column(children: [
                Text('${weatherData!.location}' , style: TextStyle(fontSize: 32 , fontWeight: FontWeight.bold),),
                Text('Updated ${weatherData!.date}' , style: TextStyle(fontSize: 24)),

              ],),
              Spacer(flex: 1,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.network('https:${weatherData!.icon}', fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                  return Text('Failed to load image');}),
                  Text('${weatherData!.temp.toInt()}',style: TextStyle(fontSize: 32 , fontWeight: FontWeight.bold)),
                  Column(
                    children: [
                      Text('max :${weatherData!.maxTemp.toInt()} ',style: TextStyle(fontSize: 22 )),
                      Text('min :${weatherData!.minTemp.toInt()} ',style: TextStyle(fontSize: 22 )),

                    ],
                  )
                ],
              ),
              Spacer(flex: 1,),
              Column(
                children: [
                  Text('${weatherData!.condition}',style: TextStyle(fontSize: 32 , fontWeight: FontWeight.bold))
                ],
              ),

              Spacer(flex: 5,),


            ],
          ),

      );
  }
}
