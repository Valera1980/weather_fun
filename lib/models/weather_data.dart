abstract class ParseResult {
  double temperature;
  int condition;
  String cityname;
}
class WeatherData implements ParseResult{
  @override
  String cityname;

  @override
  int condition;

  @override
  double temperature;
  WeatherData(this.temperature, this.condition, this.cityname);
}