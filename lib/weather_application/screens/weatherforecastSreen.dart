import 'package:flutter/material.dart';
import 'package:flutter_projects/weather_application/api/weather_api.dart';
import 'package:flutter_projects/weather_application/model/WeatherForecastDaily.dart';
import 'package:flutter_projects/weather_application/screens/city_screen.dart';
import 'package:flutter_projects/weather_application/widgets/city_view.dart';
import 'package:flutter_projects/weather_application/widgets/daily_forecast.dart';
import 'package:flutter_projects/weather_application/widgets/detail_view.dart';
import 'package:flutter_projects/weather_application/widgets/temp_view.dart';

class WeatherForecastScreen extends StatefulWidget {
  final locationWeather;

  WeatherForecastScreen({this.locationWeather});

  @override
  _WeatherForecastScreenState createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {
  late Future<WeatherForecast> forecastObject;
  late String _cityName='Dublin';
  String weather = '';

  @override
  void initState() {
    super.initState();

    if (widget.locationWeather != null) {
      forecastObject = Future.value(widget.locationWeather);//Приводим к Future
    }
    // forecastObject.then((value) {
    //         print(value.list![0].weather![0].main);
    // }
    // );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        //automaticallyImplyLeading: false,
        title: Text("Weather app"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.my_location),
          onPressed: () {
            setState(() {
              forecastObject=WeatherApi().fetchWeatherForecast();
            });
          },
        ),
        actions: <Widget>[
          IconButton(
              onPressed: () async {
                var tappedName = await Navigator.push(context,
                    MaterialPageRoute(builder: (context) {
                  return CityScreen();
                }));
                if (tappedName != null) {
                  setState(() {
                    _cityName = tappedName;
                    forecastObject =
                        WeatherApi().fetchWeatherForecast(cityName: _cityName,isCity: true);
                  });
                }
              },
              icon: Icon(Icons.location_city))
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: FutureBuilder<WeatherForecast>(
              future: forecastObject,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    children: <Widget>[
                      SizedBox(
                        height: 50,
                      ),
                      CityView(snapshot: snapshot),
                      SizedBox(
                        height: 50,
                      ),
                      TempView(snapshot: snapshot),
                      SizedBox(
                        height: 50,
                      ),
                      DetailView(snapshot: snapshot),
                      SizedBox(
                        height: 50,
                      ),
                      ButtonListView(snapshot: snapshot),
                    ],
                  );
                } else {
                  return Center(
                    child: Text('City not found\nPlease enter correct city',
                      style: TextStyle(fontSize: 25),textAlign: TextAlign.center,)
                  );
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
