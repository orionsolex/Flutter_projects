import 'package:flutter/material.dart';
import 'package:flutter_projects/weather_application/api/weather_api.dart';
import 'package:flutter_projects/weather_application/screens/weatherforecastSreen.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class LocationScreen extends StatefulWidget {
  const LocationScreen({Key? key}) : super(key: key);

  @override
  _LocationScreenState createState() => _LocationScreenState();
}

class _LocationScreenState extends State<LocationScreen> {

  void getLocationData() async{
  var weatherInfo=await WeatherApi().fetchWeatherForecast();

  if(weatherInfo==null){
    print('Weather was null: $weatherInfo');
    return;
  }

  Navigator.push(context, MaterialPageRoute(builder: (context){
    return WeatherForecastScreen(locationWeather: weatherInfo,);
  }));
  }

  @override
  void initState() {
    super.initState();
    getLocationData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SpinKitDoubleBounce(
          color: Colors.black87,size: 100.0,
        ),
      ),
    );
  }
}
