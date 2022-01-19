import 'package:flutter/material.dart';
import 'package:flutter_projects/model/offices.dart';

void main() => runApp(Myapp());

class Myapp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Json Demo',
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyHomePage> {
late Future<OfficesList> officeList;

  @override
  void initState() {
    super.initState();
    officeList = getOfficesList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Manual JSON Serialization'),
        centerTitle: true,
      ),
      body: FutureBuilder<OfficesList>(
        future: officeList,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: snapshot.data!.offices.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text('${snapshot.data!.offices[index].name}'),
                      subtitle:
                          Text('${snapshot.data!.offices[index].address}'),
                      leading: Image.network(
                          '${snapshot.data!.offices[index].image}'),
                      isThreeLine: true,
                    ),
                  );
                });
          } else if (snapshot.hasError) {
            return Text('${snapshot.error}');
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
