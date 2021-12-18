import 'package:flutter/material.dart';

void main() => runApp(MyStatelessWidget());

class MyStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text("Дырявый кошель"),
          centerTitle: true,
        ),
        body: Center(
            child: Stack(
          fit: StackFit.expand,
          children: <Widget>[
            Image(image: AssetImage("assets/images/bg.jpg")),
            Image.asset("assets/icons/icon.png")
          ],
        )),
      ),
    );
  }
}
