import 'package:flutter/material.dart';
import 'package:flutter_projects/db/database.dart';
import 'package:flutter_projects/model/student.dart';

//ПРИМЕР НЕ РАБОТАЕТ, ПИШЕТ НЕТ ДАННЫХ

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SQLite CRUD',
      home: MyStateFulWidget(),
    );
  }
}

class MyStateFulWidget extends StatefulWidget {
  @override
  _MyState createState() => _MyState();
}

class _MyState extends State<MyStateFulWidget> {
  final GlobalKey<FormState> _formstate = GlobalKey<FormState>();
  final _studentController = TextEditingController();

  Future<List<Student>> _studentList = DBProvider().getStudents();
  late String _studentName;
  int? studentID;
  bool isUpdate = false;

  @override
  void initState() {
    super.initState();

    updateStudentList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('SQLite CRUD'),
        centerTitle: true,
      ),
      body: Column(
        children: <Widget>[
          Form(
            autovalidateMode: AutovalidateMode.always,
            key: _formstate,
            child: Column(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.only(left: 10, right: 10, bottom: 10),
                  child: TextFormField(
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please Enter student name';
                      }
                      if (value.trim() == "") return 'Only space is not valid';
                      return null;
                    },
                    onSaved: (value) {
                      _studentName = value!;
                    },
                    controller: _studentController,
                    decoration: InputDecoration(
                        focusedBorder: new UnderlineInputBorder(
                            borderSide: new BorderSide(
                                color: Colors.greenAccent,
                                width: 2,
                                style: BorderStyle.solid)),
                        labelText: "Student name",
                        icon: Icon(
                          Icons.people,
                          color: Colors.black,
                        ),
                        fillColor: Colors.white,
                        labelStyle: TextStyle(color: Colors.black)),
                  ),
                )
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              MaterialButton(
                onPressed: () {
                  if (isUpdate) {
                    if (_formstate.currentState!.validate()) {
                      _formstate.currentState!.save();
                      DBProvider()
                          .updateStudent(Student(studentID, _studentName))
                          .then((value) {
                        setState(() {
                          isUpdate = false;
                        });
                      });
                    }
                  } else {
                    if (_formstate.currentState!.validate()) {
                      _formstate.currentState!.save();
                      DBProvider().insertStudent(Student(null, _studentName));
                      _studentController.text = '';
                      updateStudentList();
                    }
                  }
                },
                color: Colors.green,
                child: Text(
                  isUpdate ? "UPDATE" : "ADD",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(padding: EdgeInsets.all(10)),
              MaterialButton(
                onPressed: () {
                  _studentController.text = "";
                  setState(() {
                    isUpdate = false;
                    studentID = null;
                  });
                },
                color: Colors.green,
                child: Text(
                  isUpdate ? "CANCEL UPDATE" : "CLEAR",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
          const Divider(
            height: 5.0,
          ),
          Expanded(
            child: FutureBuilder(
              future: _studentList,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return generateList(snapshot.data as List<Student>);
                }
                if (snapshot.data == null) {
                  return Text('No data found');
                }
                return CircularProgressIndicator();
              },
            ),
          ),
        ],
      ),
    );
  }

  void updateStudentList() {
    setState(() {
      _studentList = DBProvider().getStudents();
    });
  }

  SingleChildScrollView generateList(List<Student> students) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: DataTable(
          columns: [
            DataColumn(label: Text('Name')),
            DataColumn(label: Text('DELETE'))
          ],
          rows: students
              .map((e) => DataRow(cells: [
                    DataCell(Text(e.name), onTap: () {
                      setState(() {
                        isUpdate = true;
                        studentID = e.id;
                      });
                      _studentController.text = e.name;
                    }),
                    DataCell(IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        DBProvider().deleteStudent(e);
                        updateStudentList();
                      },
                    ))
                  ]))
              .toList(),
        ),
      ),
    );
  }
}
