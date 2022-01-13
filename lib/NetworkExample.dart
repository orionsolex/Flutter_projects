import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Networking',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyHomePage> {

late String _data;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Networking'),
        centerTitle: true,
      ),
      body: Container(
        child: Text(_data),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _data=loadData();
  }
}


Future<http.Response> getData() async {
  var url=Uri.https('www.googleapis.com', '/books/v1/volumes', {'q': '{http}'});
  return await http.get(url);
}

String loadData() {
  Future<String> result=getData().then((response) {
    if (response.statusCode == 200) {
      print(response.body);
    } else {
      print(response.statusCode);
    }
    return response.body.toString();
  }).catchError((onError) {
    debugPrint(onError.toString());
  });
  return result.toString();
}