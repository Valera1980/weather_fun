import 'package:clima/models/api_url.dart';

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