import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_projects/wearher_application/model/WeatherForecastDaily.dart';
import 'package:flutter_projects/wearher_application/utilities/constants.dart';

class WeatherApi{
Future<WeatherForecast> fetchWeatherForecastByCity(String cityName) async{
  var queryParameters={
    'APPID':Constants.WEATHER_APP_ID,
    'units':'metrics',
    'q':cityName,
  };
  
  var uri=Uri.https(Constants.WEATHER_BASE_URL_DOMAIN, Constants.WEATHER_FORECAST_PATH,queryParameters);

  log('Request: ${uri.toString()}');

  var response=await http.get(uri);

  print('Response: ${response.body}');

  if(response.statusCode==200){
    return WeatherForecast.fromJson(json.decode(response.body));
  }else{
    throw Exception('Error response');
  }
}
}