import 'package:flutter/material.dart';
import 'package:weather_app/ui/weather_forcast.dart';

void main() {
  runApp(new MaterialApp(
    theme: ThemeData(
      primaryColor: Colors.pink,
      accentColor: Colors.grey
    ),
    home: WeatherForecast(),
  ));
}
