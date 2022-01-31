import 'dart:developer';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  ReadWriteFileExampleState createState() => ReadWriteFileExampleState();

}

class ReadWriteFileExampleState extends State<MyApp> {
  final TextEditingController _textEditingController = TextEditingController();

  static const String localFileName = 'demo_localfile.txt';
  String _localFileContent = '';
  String _localFilePath = localFileName;

  @override
  void initState() {
    super.initState();
    this._readTextFromLocaFile();
    this._getFile.then((file) =>
        setState(() => this._localFilePath = file.path));
  }

  @override
  Widget build(BuildContext context) {
    FocusNode textFieldFocusNode = FocusNode();
    return MaterialApp(
      title: 'Read/Write file demo',
      home: Scaffold(
        appBar: AppBar(
          title: Text('Read/Write file demo'),
          centerTitle: true,
        ),
        body: ListView(
          padding: EdgeInsets.all(20.0),
          children: <Widget>[
            Text('Write to local file', style: TextStyle(fontSize: 20),),
            TextField(focusNode: textFieldFocusNode,
              controller: _textEditingController,
              maxLines: null,
              style: TextStyle(fontSize: 20),),
            ButtonBar(
              children: <Widget>[
                MaterialButton(onPressed: () {
                  _readTextFromLocaFile();
                  _textEditingController.text = _localFileContent;
                  FocusScope.of(context).requestFocus(textFieldFocusNode);
                  log('String successfuly loaded from local file');
                },
                  child: Text('Load', style: TextStyle(fontSize: 20),),),
                MaterialButton(onPressed: () async{
                  await _writeTextToFile(_textEditingController.text);
                  _textEditingController.clear();
                  await _readTextFromLocaFile();
                  log('String successfuly loaded from local file');
                },
                  child: Text('Save', style: TextStyle(fontSize: 20),),),
              ],
            ),
            Divider(height: 20,),
            Text('Local file Path', style: Theme
                .of(context)
                .textTheme
                .headline6,),
            Text(this._localFilePath, style: Theme
                .of(context)
                .textTheme
                .subtitle1,),
            Divider(height: 20,),
            Text('Local file Content', style: Theme
                .of(context)
                .textTheme
                .headline6,),
            Text(this._localFileContent, style: Theme
                .of(context)
                .textTheme
                .subtitle1,),
          ],
        ),
      ),
    );
  }


  Future<String> get _getLocalPath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  Future<File> get _getFile async {
    final path = await _getLocalPath;
    return File('$path/$localFileName');
  }

  Future<File> _writeTextToFile(String text) async {
    final file = await _getFile;
    return file.writeAsString(text);
  }

  Future _readTextFromLocaFile() async {
    String content;
    try {
      final file = await _getFile;
      content = await file.readAsString();
    } catch (e) {
      content = 'Error loading lacal file^ $e';
    }
    setState(() {
      this._localFileContent = content;
    });
  }
}