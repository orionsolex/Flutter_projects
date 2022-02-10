import 'package:flutter/material.dart';
import 'package:flutter_projects/weather_application/screens/weatherforecastSreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WeatherForecastScreen(),
      theme: ThemeData(primarySwatch: Colors.blue),
    );
  }
}
