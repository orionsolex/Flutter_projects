import 'package:flutter/material.dart';
import 'package:flutter_projects/weather_application/model/WeatherForecastDaily.dart';
import 'package:flutter_projects/weather_application/utilities/forecast_utils.dart';

class CityView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;

  const CityView({required this.snapshot});

  @override
  Widget build(BuildContext context) {
    var forecastList = snapshot.data!.list;
    var city = snapshot.data!.city!.name;
    var country = snapshot.data!.city!.country;
    var formattedDate =
        DateTime.fromMillisecondsSinceEpoch(forecastList![0].dt! * 1000);
    return Container(
      child: Column(
        children: <Widget>[
          Text(
            '$city $country',
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 28.0,
                color: Colors.black),
          ),
          Text(
            '${Util.getFormattedDate(formattedDate)}',
            style: TextStyle(
              fontSize: 15.0,
            ),
          ),
        ],
      ),
    );
  }
}
