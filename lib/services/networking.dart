import 'dart:convert';

import 'package:clima/models/weather_data.dart';
import 'package:http/http.dart';

class NetworkFetcher {
  final String url;
  NetworkFetcher(this.url);
  Future<WeatherData> queryWeatherData() async {
    try{
      Response r = await get(this.url);
      return this._decodeData(r);
    }catch(e){
      print('error');
      print(e);
      return null;
    }
  }
  WeatherData _decodeData(Response res) {
    var rawData = res.body;
    var jsonData = jsonDecode(rawData);
    double temperature = jsonData['main']['temp'].toDouble();
    int condition  = jsonData['weather'][0]['id'];
    String cityname  = jsonData['name'];
    return WeatherData(temperature,condition,cityname);
  }
}