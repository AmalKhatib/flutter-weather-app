import 'dart:convert';

import 'package:weather_app/model/weather_forcast_model.dart';
import 'package:weather_app/util/forecast_util.dart';
import 'package:http/http.dart' as http;

class Network{
  Future<WeatherForecastModel> getForecast({String cityName}) async {
    final baseUrl = "http://api.openweathermap.org/data/2.5/weather?q=$cityName&appid=${Util.appID}";

    final response = await http.Client().get(Uri.parse(baseUrl));

    if(response.statusCode == 200){
      return WeatherForecastModel.fromJson(jsonDecode(response.body));
    }else{
      throw Exception("Error getting data");
    }
  }
}