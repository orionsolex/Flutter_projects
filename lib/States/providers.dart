import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    User def = User('def', 'def', 'def');
    List<User> initUserList = [def];
    return MaterialApp(
      title: 'Provider Memo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: MultiProvider(
        providers: [
          ChangeNotifierProvider<CountProvider>.value(value: CountProvider()),
          FutureProvider<List<User>>(
              create: (_) async => UserProvider().loadUserData(),
              initialData: initUserList),
          StreamProvider(create:  (_)=>EventProvider().intStream(), initialData: 0)
        ],
        child: DefaultTabController(
            length: 3,
            child: DefaultTabController(
                length: 3,
                child: Scaffold(
                  appBar: AppBar(
                    title: Text("Provider Demo"),
                    centerTitle: true,
                    bottom: TabBar(
                      tabs: <Widget>[
                        Tab(
                          icon: Icon(Icons.add),
                        ),
                        Tab(
                          icon: Icon(Icons.person),
                        ),
                        Tab(
                          icon: Icon(Icons.message),
                        ),
                      ],
                    ),
                  ),
                  body: TabBarView(
                    children: <Widget>[
                      MyCountPage(),
                      MyUserPage(),
                      MyEventPage(),
                    ],
                  ),
                ))),
      ),
    );
  }
}

class MyEventPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _value=Provider.of<int>(context);
    return Container(
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'StreamPovider Example',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 50,
            ),
            Text('${_value.toString()}',style: Theme.of(context).textTheme.headline6,)
          ],
        ),
      ),
    );
  }
}

class MyUserPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
//изменение состояния через Future
    return Column(
      children: <Widget>[
        Padding(
          padding: EdgeInsets.all(10.0),
          child: Text(
            'FutureProvider Example, user loaded from File',
            style: TextStyle(fontSize: 17),
          ),
        ),
        Consumer(
          builder: (context, List<User> users, _) {
            return Expanded(
                child: users == null
                    ? Center(child: CircularProgressIndicator())
                    : Container(
                        child: ListView.builder(
                            itemCount: users.length,
                            itemBuilder: (context, index) {
                              return Container(
                                height: 50,
                                color: Colors.grey[(index * 200) % 400],
                                child: Center(
                                  child: Text(
                                      '${users[index].firstName} ${users[index].lastName} ${users[index].age}'),
                                ),
                              );
                            })));
          },
        )
      ],
    );
  }
}

class MyCountPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    CountProvider _state = Provider.of<CountProvider>(context); //изменение состояния через ChangeNotifierProvider
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'ChangeNotifierProvider Example',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 50,
            ),
            Text(
              '${_state.countValue}',
              style: Theme.of(context).textTheme.headline6,
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: <Widget>[
                IconButton(
                  onPressed: () => _state._decrementCount(),
                  icon: Icon(Icons.remove),
                  color: Colors.red,
                ),
                Consumer<CountProvider>(
                  builder: (context, value, child) {
                    return IconButton(
                        onPressed: () => value._incrementCount(),
                        icon: Icon(Icons.add),
                        color: Colors.green);
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class CountProvider extends ChangeNotifier {
  int _count = 0;

  int get countValue => _count;

  void _incrementCount() {
    _count++;
    notifyListeners();
  }

  void _decrementCount() {
    _count--;
    notifyListeners();
  }
}

//user model
class User {
  final String firstName, lastName, age;

  const User(this.firstName, this.lastName, this.age);

  User.fromJson(Map<String, dynamic> json)
      : this.firstName = json['first_name'],
        this.lastName = json['last_name'],
        this.age = json['age'];
}

//user List Model
class UserList {
  final List<User> users;

  UserList(this.users);

  UserList.fromJson(List<dynamic> usersJson)
      : users = usersJson.map((user) => User.fromJson(user)).toList();
}

// FutureProvider
class UserProvider {
  final String _dataPath = "assets/json/user.json";
  late List<User> users;

  Future<String> loadAssets() async {
    return await Future.delayed(Duration(seconds: 10), () async {
      return await rootBundle.loadString(_dataPath);
    });
  }

  Future<List<User>> loadUserData() async {
    var dataString = await loadAssets();
    Map<String, dynamic> jsonUserData = jsonDecode(dataString);
    users = UserList.fromJson(jsonUserData['users']).users;
    print('done loading user!' + jsonEncode(users));
    return users;
  }
}

//Streamprovider
class EventProvider{
  Stream<int> intStream(){
    Duration interval=Duration(seconds: 2);
    return Stream<int>.periodic(interval,(int _count)=>_count++);
  }
}
