import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Util{
  static String getFormattedDate(DateTime dateTime){
    return DateFormat('EEEE, MMM d, y').format(dateTime); //Tue, May 5, 2022
  }

  static getItem(IconData iconData,int value,String units){
    return Column(
      children: <Widget>[
        Icon(
          iconData,color: Colors.black,size: 28.0,
        ),
        SizedBox(height: 10.0,),
        Text('$value',style: TextStyle(fontSize: 20.0,color: Colors.black),),
        SizedBox(height: 10.0,),
        Text('$units',style: TextStyle(fontSize: 15.0,color: Colors.black),)
      ],
    );
  }
}