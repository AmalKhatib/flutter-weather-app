import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:weather_app/model/weather_forcast_model.dart';
import 'package:weather_app/network/network.dart';
import 'package:weather_app/util/convert_icon.dart';
import 'package:weather_app/util/current_date.dart';

class WeatherForecast extends StatefulWidget {
  @override
  _WeatherForecastState createState() => _WeatherForecastState();
}

class _WeatherForecastState extends State<WeatherForecast> {

  Future<WeatherForecastModel> forecastObjects;
  String _cityName = "London";

  @override
  void initState() {
    super.initState();
    forecastObjects = getWeather(cityName: _cityName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          textFieldView(),
          Container(
            child: FutureBuilder<WeatherForecastModel>(
              future: forecastObjects,
              builder: (BuildContext context, AsyncSnapshot<WeatherForecastModel> snapshot){
                if(snapshot.hasData){
                  return Column(
                    children: <Widget>[
                      midView(snapshot)
                    ],
                  );
                }else{
                  return Container(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }

  Widget textFieldView(){
    return Container(
      child: Padding(
        padding: const EdgeInsets.only(top: 14.0, left: 14.0, right: 14.0 ),
        child: TextField(
          cursorColor: Colors.pinkAccent,
          decoration: InputDecoration(
            hintText: "city name",
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            contentPadding: EdgeInsets.all(8)
          ),
          onSubmitted: (value){
            setState(() {
              _cityName = value;
              forecastObjects = getWeather(cityName: _cityName);
            });
          },
        ),
      ),
    );
  }

  Widget midView(AsyncSnapshot<WeatherForecastModel> weather){
    return Container(
      child: Padding(
        padding: const EdgeInsets.all(14.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text("${weather.data.name}, ${weather.data.sys.country}", style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18, color: Colors.black87
            ),),
            Text("${getCurrentDate()}", style: TextStyle(fontSize: 15)),

            SizedBox(height: 10,),

            //..... main weather icon ........//
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: getWeatherIcon(weatherDescription: weather.data.weather[0].main, color: Colors.pinkAccent, size: 195),
            ),

            //..... temp | weather desc ....../
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text("${weather.data.main.temp.toStringAsFixed(0)} °F", style: TextStyle(fontSize: 34),),
                  Text("${weather.data.weather[0].description.toUpperCase()}"),

                ],
              ),
            ),

            //..... humidity | wind | maxTemp ....../
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("${weather.data.wind.speed.toStringAsFixed(1)} mi/h"),
                        Icon(FontAwesomeIcons.wind, color: Colors.brown, size: 20,)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text("${weather.data.main.humidity.toStringAsFixed(1)} %"),
                        Icon(FontAwesomeIcons.solidGrinBeamSweat, color: Colors.brown, size: 20,)
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text("${weather.data.main.tempMax.toStringAsFixed(0)} °F"),
                        Icon(FontAwesomeIcons.temperatureHigh, color: Colors.brown, size: 20,)
                      ],
                    ),
                  )
                ],
              ),
            ),

          ],
        ),
      ),
    );
  }

  Future<WeatherForecastModel> getWeather({String cityName}) => Network().getForecast(cityName: _cityName);
}
