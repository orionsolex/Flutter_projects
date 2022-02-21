import 'package:flutter/material.dart';
import 'package:flutter_projects/BLoC_stream_example/color_bloc.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      home: MyWidget(),
    );
  }
}

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  _MyWidgetState createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  ColorBloc _bloc = ColorBloc();

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('BLoC with Stream'), centerTitle: true),
      body: Center(
        child: StreamBuilder( // оборачиваем виджет в Стримбилдер и подписываемся на стрим
          stream: _bloc.outputStateStream,
          initialData: Colors.red,
          builder: (context, AsyncSnapshot<Color> snapshot) {
            return AnimatedContainer(
              height: 100.0,
              width: 100.0,
              color: snapshot.data,
              duration: Duration(milliseconds: 500),
            );
          },
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          FloatingActionButton(
            onPressed: () {
              _bloc.inputEventSink.add(ColorEvent.event_red); // передаем ивент
            },
            backgroundColor: Colors.red,
          ),
          SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              _bloc.inputEventSink.add(ColorEvent.event_green); // передаем ивент
            },
            backgroundColor: Colors.green,
          ),
        ],
      ),
    );
  }
}
