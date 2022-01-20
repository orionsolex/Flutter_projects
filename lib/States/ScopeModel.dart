import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';

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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Demo Inherited'),
        centerTitle: true,
      ),
      body: ListView(
        children: <Widget>[
          ScopedModel<MyModel>(
            // оборачиваем в наследуемый виджет
            model: MyModel(),
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


    return Card(
      elevation: 4,
      child: Column(
        children: [
          Text(
            '(Root widget)',
            style: Theme.of(context).textTheme.bodyText1,
          ),
          Text(
            '(0)',
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
    return ScopedModelDescendant<MyModel>(
        //оборачиваем нашу карту в виджет модели
        rebuildOnChange: true, // отвечает за отслеживание изменений и перересовку
        builder: (context, child, model) => Card(
              margin: EdgeInsets.all(4.0).copyWith(bottom: 32.0),
              color: Colors.yellowAccent,
              child: Column(
                children: <Widget>[
                  Text('(Child widget)'),
                  Text(
                    '(${model.counterValue})',
                    style: Theme.of(context).textTheme.bodyText1,
                  ),
                  ButtonBar(
                    children: <Widget>[
                      IconButton(
                        onPressed: () => model._decrementCounter(),
                        icon: Icon(Icons.remove),
                        color: Colors.red,
                      ),
                      IconButton(
                        onPressed: () => model._incrementCounter(),
                        icon: Icon(Icons.add),
                        color: Colors.green,
                      )
                    ],
                  )
                ],
              ),
            ));
  }
}

class MyModel extends Model {
  int _counter = 0;

  int get counterValue => _counter;

  void _incrementCounter() {
    _counter++;
    notifyListeners();
  }

  void _decrementCounter() {
    _counter++;
    notifyListeners();
  }
}
