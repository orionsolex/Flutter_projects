import 'package:flutter/material.dart';
import 'package:flutter_projects/weather_application/api/weather_api.dart';
import 'package:flutter_projects/weather_application/model/WeatherForecastDaily.dart';
import 'package:flutter_projects/weather_application/widgets/city_view.dart';
import 'package:flutter_projects/weather_application/widgets/temp_view.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class WeatherForecastScreen extends StatefulWidget {

  @override
  _WeatherForecastScreenState createState() => _WeatherForecastScreenState();
}

class _WeatherForecastScreenState extends State<WeatherForecastScreen> {

  late Future<WeatherForecast> forecastObject;
  String cityName='Moscow';
   String weather='';

  @override
  void initState() {
         super.initState();
    forecastObject=WeatherApi().fetchWeatherForecastByCity(cityName);
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
        title: Text("Weather app"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.my_location),
          onPressed: (){},
        ),
        actions: <Widget>[
          IconButton(onPressed: (){}, icon: Icon(Icons.location_city))
        ],
      ),
      body: ListView(
        children: <Widget>[
          Container(
            child: FutureBuilder<WeatherForecast>(
              future: forecastObject,
              builder: (context,snapshot){
                if(snapshot.hasData){
                  return Column(
                    children: <Widget>[
                      SizedBox(height: 50,),
                      CityView(snapshot: snapshot),
                      SizedBox(height: 50,),
                      TempView(snapshot: snapshot),
                    ],
                  );
                }else{
                  return Center(
                    child: SpinKitDoubleBounce(
                      color: Colors.black,
                      size: 100.0,
                    ),
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
