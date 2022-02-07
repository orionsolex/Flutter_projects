import 'package:flutter/material.dart';
import 'package:flutter_projects/wearher_application/screens/weatherforecastSreen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "IndieFlower"),
      home: WeatherForecastScreen(),
    );
  }
}
