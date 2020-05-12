import 'dart:convert';

import 'package:http/http.dart';

abstract class ParseResult {
  double temperature;
  int condition;
  String cityname;
}
class Resp implements ParseResult{
  @override
  String cityname;

  @override
  int condition;

  @override
  double temperature;
  Resp(this.temperature, this.condition, this.cityname);
}

class UrlParams {
  String prefixUrl;
  double long;
  double lat ;
  String apiKey;
}
class UrlParamsBuilder {
  UrlParams url = UrlParams();
  UrlParamsBuilder withPrefix(String prx) {
    url.prefixUrl = prx;
    return this;
  }
  UrlParamsBuilder withLat(double lat) {
    url.lat = lat;
    return this;
  }
  UrlParamsBuilder withLong(double long) {
    url.long = long;
    return this;
  }
  UrlParamsBuilder withApiKey(String apiKey) {
    url.apiKey = apiKey;
    return this;
  }
  String build() {
    return url.prefixUrl + 'units=metric' +
        '&lat=' + url.lat.toString() +
        '&lon=' + url.long.toString() +
        '&appId=' + url.apiKey;
  }
}


class NetworkFetcher {
  final String url;
  NetworkFetcher(this.url);
  Future<Resp> queryWeatherData() async {
    try{
      Response r = await get(this.url);
      return this._decodeData(r);
    }catch(e){
      return null;
    }
  }
  Resp _decodeData(Response res) {
    var rawData = res.body;
    var jsonData = jsonDecode(rawData);
    double temperature = jsonData['main']['temp'];
    int condition  = jsonData['weather'][0]['id'];
    String cityname  = jsonData['name'];
    return Resp(temperature,condition,cityname);
  }
}