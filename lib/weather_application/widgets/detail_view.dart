import 'package:flutter/material.dart';
import 'package:flutter_projects/weather_application/model/WeatherForecastDaily.dart';
import 'package:flutter_projects/weather_application/utilities/forecast_utils.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DetailView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;

  const DetailView({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data?.list;
    var humidity = forecastList?[0].humidity;
    var wind = forecastList?[0].speed;
    var pressure = forecastList![0].pressure!* 0.750062;

    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          Util.getItem(FontAwesomeIcons.thermometerThreeQuarters,
              pressure.round(), 'mm Hg'),
          Util.getItem(FontAwesomeIcons.cloudRain, humidity!, '%'),
          Util.getItem(FontAwesomeIcons.wind, wind!.toInt(), 'm/s')
        ],
      ),
    );
  }
}
