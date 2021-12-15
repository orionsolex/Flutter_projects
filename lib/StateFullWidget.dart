import 'dart:async';
import 'package:flutter/material.dart';

void main() => runApp(MyStatefullWidget());

class MyStatefullWidget extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyFirstAppState(); // TODO: implement createState
  }
}

class _MyFirstAppState extends State<MyStatefullWidget> {
  late bool _loading;
  late double _progressValue;
  late var _icon;

  @override
  void initState() {
    // TODO: implement initState
    _loading = false;
    _progressValue = 0.0;
    _icon = Icons.cloud_download;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            setState(() {
              _loading = !_loading;
              _updateProgress();
            });
          },
          child: Icon(_icon),
        ),
        backgroundColor: Colors.indigo,
        appBar: AppBar(
          title: Text("Хромая кляча"),
          centerTitle: true,
        ),
        body: Center(
          child: Container(
            padding: EdgeInsets.all(16),
            child: _loading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      LinearProgressIndicator(
                        value: _progressValue,
                      ),
                      Text("${(_progressValue * 100).round()}%",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                    ],
                  )
                : Text("Press button to download",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
          ),
        ),
      ),
    ); // TODO: implement build
  }

  void _updateProgress() {
    const oneSec = Duration(seconds: 1);
    Timer.periodic(oneSec, (timer) {
      setState(() {
        _progressValue += 0.1;
        ((_progressValue * 100) % 2) == 0
            ? _icon = Icons.swap_vertical_circle_outlined
            : _icon = Icons.swap_horizontal_circle;
        if (_progressValue.toStringAsFixed(1) == "1.0") {
          _loading = false;
          timer.cancel();
          _icon = Icons.cloud_done;
          _progressValue = 0.0;
          return;
        }
      });
    });
  }
}
