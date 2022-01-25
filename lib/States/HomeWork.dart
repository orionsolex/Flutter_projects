import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:randomizer/randomizer.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'HomeWork Provider',
        home: ChangeNotifierProvider<MyProvider>(create: (BuildContext context) =>MyProvider(),
        child:Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              "Home Work Provider",
              style: TextStyle(color: Colors.amberAccent),
            ),
          ),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MyContainer(),
              MySwitch()
            ],
          )
      )        ),
        // home: MultiProvider(
        //   providers: [
        //     ChangeNotifierProvider<MyProvider>.value(value: MyProvider()),
        //     ChangeNotifierProvider<MyProvider>(create: (context)=>MyProvider(),)
        //   ] ,
        //   child: Scaffold(
        //       appBar: AppBar(
        //         centerTitle: true,
        //         title: Text(
        //           "Home Work Provider",
        //           style: TextStyle(color: Colors.amberAccent),
        //         ),
        //       ),
        //       body: Column(
        //         mainAxisAlignment: MainAxisAlignment.center,
        //         children: <Widget>[
        //           MyContainer(),
        //           MySwitch()
        //         ],
        //       )
        //   ),
        // )
    );
  }
}

class MyContainer extends StatelessWidget {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: Duration(seconds: 1),
      curve: Curves.ease,
      width: selected ? 200.0 : 100.0,
      height: selected ? 100.0 : 200.0,
      color: selected ? Colors.red : Colors.deepPurpleAccent,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              height: 50,
            ),
          ]),
    );
  }
}

class MySwitch extends StatelessWidget {
  bool stat
    MyProvider _state = Provider.of<MyProvider>(context);
  @override
  Widget build(BuildContext context) {
    return Switch(value: _state._switchState, onChanged: (true){

    });
  }

}

class MyProvider extends ChangeNotifier {
  var _color;
  bool _switchState=false;
  Randomizer randomizer = Randomizer();

  String get color => _color;

  void _randomizecolor() {
    _color = randomizer.getrandomcolor();
    notifyListeners();
  }


}