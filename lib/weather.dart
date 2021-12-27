import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyStatelessWidget());

class MyStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Wheather",
            style: TextStyle(color: Colors.black),
          ),
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(onPressed: () {}, icon: Icon(Icons.menu)),
          iconTheme: IconThemeData(color: Colors.black),
          systemOverlayStyle: SystemUiOverlayStyle(
              systemNavigationBarIconBrightness: Brightness.light),
          actions: <Widget>[
            IconButton(onPressed: () {}, icon: Icon(Icons.settings))
          ],
        ),
        body: _buildBody(),
      ),
    );
  }
}

Widget _buildBody() {
  return SingleChildScrollView(
    child: Column(
      children: <Widget>[
        _headerImage(),
        SafeArea(
            child: Padding(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _weatherDescription(),
              Divider(),
              _temperature(),
              Divider(),
              _temperatureForecast(),
              Divider(),
              _footerRatings(),
            ],
          ),
        )),
      ],
    ),
  );
}

Image _headerImage() {
  return Image(
    image: AssetImage("assets/images/picture.jpg"),
    fit: BoxFit.cover,
  );
}

Column _weatherDescription() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Text(
        'Tuesday - May 22',
        style: TextStyle(
          fontSize: 32,
          fontWeight: FontWeight.bold,
        ),
      ),
      Divider(),
      Text(
        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempficia deserunt mollit anim id est laborum',
        style: TextStyle(
          color: Colors.black54,
        ),
      ),
    ],
  );
}

Row _temperature() {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: <Widget>[
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Icon(
            Icons.wb_sunny,
            color: Colors.yellow,
          )
        ],
      ),
      SizedBox(width: 16),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Row(
            children: <Widget>[
              Text(
                '15 Clear',
                style: TextStyle(color: Colors.deepPurple),
              )
            ],
          ),
          Row(
            children: <Widget>[
              Text(
                'Moscovskaya oblast, Moscow',
                style: TextStyle(color: Colors.grey),
              )
            ],
          )
        ],
      )
    ],
  );
}

Wrap _temperatureForecast() {
  return Wrap(
    spacing: 10,
    children: List.generate(8, (int index) {
      return Chip(
          avatar: Icon(
            Icons.wb_cloudy,
            color: Colors.blueAccent,
          ),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(4.0),
              side: BorderSide(color: Colors.grey)),
          backgroundColor: Colors.grey.shade100,
          label: Text(
            '${index + 20}',
            style: TextStyle(fontSize: 15),
          ));
    }),
  );
}

Row _footerRatings() {
  var stars = Row(
    mainAxisSize: MainAxisSize.min,
    children: <Widget>[
      Icon(Icons.star, size: 15.0, color: Colors.yellow[500]),
      Icon(Icons.star, size: 15.0, color: Colors.yellow[500]),
      Icon(Icons.star, size: 15.0, color: Colors.yellow[500]),
      Icon(Icons.star, size: 15.0, color: Colors.black),
      Icon(Icons.star, size: 15.0, color: Colors.black),
    ],
  );
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Text(
        'Info whith openweathermap.org',
        style: TextStyle(
          fontSize: 15.0,
        ),
      ),
      stars,
    ],
  );
}
