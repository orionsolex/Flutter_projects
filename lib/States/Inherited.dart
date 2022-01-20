import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Inherited Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MyHomePage(title: 'Inherited Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();

  MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  int get counterValue => _counter;

  void _incrementCounter() => setState(() => _counter++);

  void _decrementCounter() => setState(() => _counter--);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Inherited'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          MyInheritedWidget( // оборачиваем в наследуемый виджет
            myState: this,
             child: AppRootWidget(),
          ),
        ],
      ),
    );
  }
}

class AppRootWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rootWidgetState=MyInheritedWidget.of(context)!.myState; //добавляем состояние в дочений виджет

    return Card(
      elevation: 4,
      child: Column(
        children: [
          Text(
            '(Root widget)',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            '(${rootWidgetState.counterValue})',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Counter(),
                Counter(),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Counter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final rootWidgetState=MyInheritedWidget.of(context)!.myState; //добавляем состояние в дочений виджет
    return Card(
      margin: EdgeInsets.all(4.0).copyWith(bottom: 32.0),
      color: Colors.yellowAccent,
      child: Column(
        children: <Widget>[
          Text('(Child widget)'),
          Text(
            '(${rootWidgetState.counterValue})',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          ButtonBar(
            children: <Widget>[
              IconButton(onPressed: ()=>rootWidgetState._decrementCounter(), icon: Icon(Icons.remove),color: Colors.red,),
              IconButton(onPressed: ()=>rootWidgetState._incrementCounter(), icon: Icon(Icons.add),color: Colors.green,)
            ],
          )
        ],
      ),
    );
  }
}

class MyInheritedWidget extends InheritedWidget{
  final _MyHomePageState myState; // подвязываем состояние нашего StatfulWidget

  MyInheritedWidget({Key? key,required Widget child,required this.myState}):super(key: key,child: child);

  @override
  bool updateShouldNotify(covariant MyInheritedWidget oldWidget) {
    return this.myState.counterValue!=oldWidget.myState.counterValue;
  }

  static MyInheritedWidget?  of(BuildContext context){
    return context.dependOnInheritedWidgetOfExactType();
  }
}