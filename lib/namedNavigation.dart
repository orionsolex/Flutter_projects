import 'package:flutter/material.dart';

void main() => runApp(myStatelessWidget());

class myStatelessWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Diego bar"),
          centerTitle: true,
        ),
        body: HomePage(),
      ),
      initialRoute: '/',
      routes: {
        '/page2':(context)=>Page2(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          Navigator.pushNamed(context, '/page2');
        },
        child: Text('Move to Page 2'),
      ),
    );
  }
}

class Page2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Diego junior bar"),
        centerTitle: true,
      ),
      body: Center(
        child: ElevatedButton(onPressed: () {
          Navigator.pop(context);
        },
            child: Text('Go back fools')),
      ),
    );
  }
}
