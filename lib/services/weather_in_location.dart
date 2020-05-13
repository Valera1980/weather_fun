import 'package:clima/models/weather_data.dart';
import 'package:clima/utilities/constants.dart';
import 'package:clima/utilities/url_api_builder.dart';
import 'package:geolocator/geolocator.dart';

import 'networking.dart';

class WeatherInLocationProvider{
  final Position pos;

  WeatherInLocationProvider(this.pos);

  Future<WeatherData> queryWeather() async{
    UrlParamsBuilder builder = UrlParamsBuilder();
    String url = builder.withPrefix('http://api.openweathermap.org/data/2.5/weather?')
        .withApiKey(appId)
        .withLat(pos.latitude)
        .withLong(pos.longitude)
        .build();
    print(url);
    NetworkFetcher fetcher = NetworkFetcher(url);
    return fetcher.queryWeatherData();
  }
}