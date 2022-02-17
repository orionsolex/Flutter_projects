import 'package:flutter/material.dart';
import 'package:flutter_projects/weather_application/model/WeatherForecastDaily.dart';

import 'forecast_card.dart';

class ButtonListView extends StatelessWidget {
  final AsyncSnapshot<WeatherForecast> snapshot;

  const ButtonListView({required this.snapshot});

  @override
  Widget build(BuildContext context) {

    var forecastList = snapshot.data!.list;
    var city = snapshot.data!.city!.name;
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Text(
          '7 day weather forecast'.toLowerCase(),
          style: TextStyle(
              fontSize: 20.0,
              color: Colors.black87,
              fontWeight: FontWeight.bold),
        ),
        Container(
          height: 140,
          padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
              itemBuilder: (context,index)=>Container(
                width: MediaQuery.of(context).size.width/2.7,
                height: 160,
                color: Colors.blueAccent,
                child: ForecastCard(snapshot,index),
              ),
              separatorBuilder: (context,index)=>SizedBox(width: 8,),
              itemCount: snapshot.data!.list!.length),
        )
      ],
    );
  }
}
