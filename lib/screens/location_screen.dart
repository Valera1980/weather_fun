import 'package:clima/models/weather_data.dart';
import 'package:clima/services/location.dart';
import 'package:clima/services/weather.dart';
import 'package:clima/services/weather_in_location.dart';
import 'package:flutter/material.dart';
import 'package:clima/utilities/constants.dart';
import 'package:geolocator/geolocator.dart';

class LocationScreen extends StatefulWidget {
  final WeatherData weatherData;
  LocationScreen({this.weatherData});
  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {
  WeatherData weatherData;
  WeatherConfigsProvider p = new WeatherConfigsProvider();
  @override
  void initState() {
    super.initState();
    this.updateUI(widget.weatherData);
  }
  updateUI(WeatherData wd){
    weatherData = wd;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('images/location_background.jpg'),
            fit: BoxFit.cover,
            colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.8), BlendMode.dstATop),
          ),
        ),
        constraints: BoxConstraints.expand(),
        child: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  FlatButton(
                    onPressed: ()async {
                      Position pos = await LocationProvider().getLocation();
                      WeatherData wd = await WeatherInLocationProvider(pos).queryWeather();
                      setState(() {
                        weatherData = wd;
                      });
                    },
                    child: Icon(
                      Icons.near_me,
                      size: 50.0,
                    ),
                  ),
                  FlatButton(
                    onPressed: ()  {

                    },
                    child: Icon(
                      Icons.location_city,
                      size: 50.0,
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 15.0),
                child: Row(
                  children: <Widget>[
                    Text(
                      weatherData.temperature.toInt().toString() + '°',
                      style: kTempTextStyle,
                    ),
                    Text(
                     // '☀️',
                      p.getWeatherIcon(weatherData.condition),
                      style: kConditionTextStyle,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.0),
                child: Text(
//                  "It's 🍦 time in San Francisco!",
                  p.getMessage(weatherData.temperature.toInt()),
                  textAlign: TextAlign.right,
                  style: kMessageTextStyle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
