import 'package:flutter/material.dart';

class SecondScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState()=>_SecondScreenstate();
}

class _SecondScreenstate extends State<SecondScreen> {
  TextEditingController textEditingController=TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text('Second screen'),
            centerTitle: true,
          ),
          body: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Padding(padding: EdgeInsets.all(32.0),
                  child: TextField(
                    controller: textEditingController,
                    style: TextStyle(fontSize: 24),
                  ),),
                ElevatedButton(onPressed: () {
                  String textToSendBack=textEditingController.text;
                  Navigator.pop(context, textToSendBack);
                },

                  child:
                  Text('Go to Second Screen',
                    style: TextStyle(fontSize: 24.0),),
                ),

              ],
            ),
          ),
        ));
  }}