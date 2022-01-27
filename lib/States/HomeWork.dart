// @dart=2.7

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:randomizer/randomizer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'HomeWork Provider',
      home: ChangeNotifierProvider<MyProvider>(
          create: (BuildContext context) => MyProvider(), child: MyContainer()),
    );
  }
}

class MyContainer extends StatelessWidget {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    MyProvider _state = Provider.of<MyProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Home Work Provider",
          style: TextStyle(color: _state._color2),
        ),
      ),
      body: Center(
        child: Column(
          children: [
            SizedBox(height: 100,),
            AnimatedContainer(
              duration: Duration(seconds: 1),
              curve: Curves.ease,
              width: 100.0,
              height: 100.0,
              color: _state._color,
            ),
            MySwitch()
          ],
        ),
      ),
    );
  }
}

class MySwitch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    MyProvider _state = Provider.of<MyProvider>(context);
    return Switch(
        value: _state._switchState,
        onChanged: (value) {
          _state._randomizecolor();
          _state.switchState=value;

        });
  }
}

class MyProvider extends ChangeNotifier {
  var _color;
  var _color2;

  get color2 => _color2;
  get color => _color;

  bool _switchState = false;

  set switchState(bool value) {
    _switchState = value;
  }

  Randomizer randomizer = Randomizer();

  void _randomizecolor() {
    _color = randomizer.getrandomcolor();
    _color2=randomizer.getrandomcolor();
    notifyListeners();
  }
}
