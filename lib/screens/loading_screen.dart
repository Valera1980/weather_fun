import 'dart:convert';
import 'package:clima/services/networking.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart';

class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();
}



class _LoadingScreenState extends State<LoadingScreen> {
  final appId ='f728ac1cd706b12c2c26b0652dd36ba6';
  void getLocation() async {
    Position pos = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    print(pos);
    UrlParamsBuilder builder = UrlParamsBuilder();
    String url = builder.withPrefix('http://api.openweathermap.org/data/2.5/weather?')
    .withApiKey(appId)
    .withLat(pos.latitude)
    .withLong(pos.longitude)
    .build();
    print(url);
    NetworkFetcher fetcher = NetworkFetcher(url);
    Resp resp = await fetcher.queryWeatherData();
    print(resp.temperature);
  }

  @override
  void initState() {
    super.initState();
    getLocation();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: RaisedButton(
          onPressed: () {
            //Get the current location
            getLocation();
          },
          child: Text('Get Location'),
        ),
      ),
    );
  }
}
