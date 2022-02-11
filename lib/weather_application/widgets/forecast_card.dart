import 'package:flutter/material.dart';
import 'package:flutter_projects/weather_application/model/WeatherForecastDaily.dart';
import 'package:flutter_projects/weather_application/utilities/forecast_utils.dart';

Widget ForecastCard(AsyncSnapshot asyncSnapshot,int index){

  var forecastList = asyncSnapshot.data!.list;
  var dayOfWeek='';
  var  date=DateTime.fromMillisecondsSinceEpoch(forecastList[index].dt*1000);
  var fullDate=Util.getFormattedDate(date);
  dayOfWeek=fullDate.split(',')[0];//обрезаем Tue
  var tempMin=forecastList[index].temp.min.toStringAsFixed(0);
  var icon=forecastList[index].getIconUrl();

return Column(
  mainAxisAlignment: MainAxisAlignment.start,
  crossAxisAlignment: CrossAxisAlignment.start,
  children: <Widget>[
    Center(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Text(
          dayOfWeek,
          style: TextStyle(fontSize: 25,color: Colors.white),
        ),
      ),
    ),
    Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Padding(padding: const EdgeInsets.all(8.0),
                child: Text(
                  '$tempMin C',
                  style: TextStyle(fontSize: 30,color: Colors.white),
                ),),
                Image.network(icon,scale: 1.2,color: Colors.white,)
              ],
            )
          ],
        )
      ],
    ),
  ],
);
}