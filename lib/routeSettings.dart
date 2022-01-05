import 'package:flutter/material.dart';

void main() =>
    runApp(MaterialApp(
      routes: {
        '/first':(context)=>FistHome(),
        '/second':(context)=>SecondHome(),
      },
        home: FistHome()));

class FistHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('First Home'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(onPressed: () {
          User user = User(name: 'Ilya', age: 15);
          Navigator.pushNamed(context, '/second',arguments: user);
        },
          child: Text('Second Home'),
        ),
      ),
    );
  }}

class SecondHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    RouteSettings? settings=ModalRoute.of(context)?.settings;
    User user=settings!.arguments as User;
    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome ${user.name} age ${user.age}'),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text('Go back'),
        ),
      ),
    );
  }
}

class User{
  final String? name;
  final int? age;

  User({this.name,this.age});
}
