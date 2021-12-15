import 'package:flutter/material.dart';

void main() {
  runApp(MaterialApp(//cupertino
      home: Scaffold(
          backgroundColor: Colors.indigo,
          appBar: AppBar(
            title: Text("My super App "),
            centerTitle: true,
          ),
          body: Center(
              child: Text("Home page",
                  style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: Colors.white))))));
}
