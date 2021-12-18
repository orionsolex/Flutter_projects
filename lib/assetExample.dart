import 'package:flutter/material.dart';

void main() => runApp(MyStatelessWidget());

class MyStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(fontFamily: "IndieFlower"),
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Wikness pocket"),
          centerTitle: true,
        ),
        body: Center(
            child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image(image: AssetImage("assets/images/bg.jpg")),
            Image.asset("assets/icons/icon.png"),
            Positioned(
                top: 16,
                left: 115,
                child: Text(
                  "My custom font",
                  style: TextStyle(
                      fontSize: 30, color: Colors.white,fontFamily: "IndieFlower"),
                ))
          ],
        )),
      ),
    );
  }
}
