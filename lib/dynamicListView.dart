import 'package:flutter/material.dart';

void main() => runApp(myStatelessWidget());

class myStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: Text("Static ListView"),
            centerTitle: true,
          ),
          body: BodyListView()),
    );
  }
}

class BodyListView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return _myListView();
  }
}

Widget _myListView() {
  final List<String> items = List<String>.generate(10000, (i) => 'Item $i');

  return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text('${items[index]}'),
            leading: Icon(
              Icons.insert_photo,
              color: Colors.red,
            ),
            trailing: Icon(Icons.keyboard_arrow_right),
          ),
        );
      });
}
