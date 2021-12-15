import 'dart:ui';

import 'package:flutter/material.dart';

void main() => runApp(myStatelessWidget());

class myStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(onPressed: null,
        child:   Icon(Icons.cloud_download),),
        backgroundColor: Colors.indigo,
        appBar: AppBar(
          title: Text("Хромая кляча"),
          centerTitle: true,
        ),
        body:  Center(child: Container(
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              LinearProgressIndicator(
                value: 23,
              ),
              Text("23 %", style: TextStyle(color: Colors.white, fontSize: 20)),
              Text("Press button to download",style: TextStyle(color: Colors.white, fontSize: 20))
            ],
          ),
        ),
        ),

      ),
    ); // TODO: implement build
    throw UnimplementedError();
  }
}
