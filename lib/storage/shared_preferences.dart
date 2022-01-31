import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Shared preferences',
      home: MySharedPreferences(),
    );
  }
}

class MySharedPreferences extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<MySharedPreferences> {
  late SharedPreferences _pref;

  static const String number_pref_key='number_pref';
  static const String bool_pref_key='bool_pref';
  int _numberPref = 0;
  bool _bollPref = false;


  @override
  void initState() {
    super.initState();
    SharedPreferences.getInstance() //получаем инстанс типа Future
    ..then((pref) {
      setState(() =>this._pref=pref);
        _loadBoolPref();
        _loadNumberPref();
      });
    }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shared preferences'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Table(
            defaultVerticalAlignment: TableCellVerticalAlignment.middle,
              children: <TableRow>[
                TableRow(children:<Widget>[
                    Text('Number Preference'),
                    Text('${_numberPref}'),
                    MaterialButton(
                      onPressed: ()=>_setNumberPref(_numberPref+1),
                      child: Text('Increment'),)
            ]
            ),
                TableRow(children:<Widget>[
                  Text('Boolean Preference'),
                  Text('${_bollPref}'),
                  MaterialButton(
                    onPressed: ()=>_setBoolPref(!_bollPref),
                    child: Text('Toogle'),)
                ]
                )
              ]
          ),
          MaterialButton(onPressed: ()=>_resetPref(),
            child: Text('Reset Data'),)
        ],
      ),
    );
  }

  Future<Null> _setNumberPref(int value) async{
    await this._pref.setInt(number_pref_key, value);
    _loadNumberPref();
  }

  Future<Null> _setBoolPref(bool value) async{
    await this._pref.setBool(bool_pref_key, value);
    _loadBoolPref();
  }

  void _loadNumberPref(){
    setState(() {
      _numberPref=_pref.getInt(number_pref_key)??0;//получить 0 если null
    });
  }

  void _loadBoolPref(){
    setState(() {
      _bollPref=_pref.getBool(bool_pref_key)??false;//получить false если null
    });
  }
  Future<Null> _resetPref() async{
    await _pref.clear();
    _loadNumberPref();
    _loadBoolPref();
  }

}
