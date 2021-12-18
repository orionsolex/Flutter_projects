
import 'package:flutter/material.dart';

void main() => runApp(CounterStatelessWidget());

class CounterStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.lightBlueAccent,
        appBar: AppBar(
          title: Text("Counter"),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text('Tap "-" decrement',
                    style: TextStyle(color: Colors.white, fontSize: 16)),
                CounterStatefullWidget(),
                Text('Tap "+" to increment',
                    style: TextStyle(color: Colors.white, fontSize: 16))
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class CounterStatefullWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _CounterWidgetState();
  }
}

class _CounterWidgetState extends State<CounterStatefullWidget> {
  int _counter = 50;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        IconButton(
          onPressed: () {
            setState(() {
              _counter--;
            });
          },
          icon: Text("-"),
        ),
        IconButton(
            onPressed: () {},
            icon: Text(
              "$_counter",
            )),
        IconButton(
            onPressed: () {
              setState(() {
                _counter++;
              });
            },
            icon: Text("+")),
      ],
    );
  }
}
