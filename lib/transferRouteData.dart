import 'package:flutter/material.dart';

void main() =>
    runApp(MaterialApp(
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
          Route route = MaterialPageRoute(builder: (context)=>SecondHome(user: user));
          Navigator.push(context, route);
        },
          child: Text('Second Home'),
        ),
      ),
    );
  }}

  class SecondHome extends StatelessWidget {
  final User user;
  SecondHome({required this.user});
  @override
  Widget build(BuildContext context) {
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
