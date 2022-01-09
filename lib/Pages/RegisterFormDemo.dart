import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_projects/Pages/UserInfoPage.dart';
import 'package:flutter_projects/model/user.dart';

class RegisterFormDemo extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterFormDemo> {
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _hidePass = true;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _storyController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();
  final _namefocus = FocusNode();
  final _phonefocus = FocusNode();
  final _passfocus = FocusNode();

  User newUser=User();

  List<String> _countries = ['Russia', 'Ukrain', 'Germany', 'France'];
  String _selectedCounty = 'Russia';

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _storyController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    _namefocus.dispose();
    _phonefocus.dispose();
    _passfocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text('Register Form'),
        centerTitle: true,
      ),
      body: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.0),
            children: [
              TextFormField(
                focusNode: _namefocus,
                autofocus: true,
                onFieldSubmitted: (_) {
                  _fieldFocusChange(context, _namefocus, _phonefocus);
                },
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Full Name *',
                  hintText: 'What do people call you?',
                  prefixIcon: Icon(Icons.person),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _nameController.clear();
                    },
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                validator: (value) {
                  final _nameExp = RegExp(r'^[A-Za-z ]+$');
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  } else if (!_nameExp.hasMatch(value)) {
                    return 'Please enter alphabetical characters.';
                  } else {
                    return null;
                  }
                },
                onSaved: (value)=>newUser.name=value as String,
              ),

              SizedBox(
                height: 10,
              ),
              TextFormField(
                focusNode: _phonefocus,
                onFieldSubmitted: (_) {
                  _fieldFocusChange(context, _phonefocus, _passfocus);
                },
                controller: _phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  hintText: 'Where can we reach you',
                  helperText: 'Phone format: (xxx)xxx-xxxx',
                  prefixIcon: Icon(Icons.call),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      _phoneController.clear();
                    },
                    onLongPress: () {
                      _phoneController.clear();
                    },
                    child: Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.black, width: 2.0),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20.0)),
                    borderSide: BorderSide(color: Colors.blue, width: 2.0),
                  ),
                ),
                keyboardType: TextInputType.phone,
                inputFormatters: [
                  // FilteringTextInputFormatter.digitsOnly,
                  FilteringTextInputFormatter(RegExp(r'^[()\d -]{1,15}$'),
                      allow: true),
                ],
                validator: (value) =>
                _validatePhone(value as String)
                    ? null
                    : 'Phone must be like (xxx)xxx-xxxx',
                onSaved: (value)=>newUser.phone=value as String,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                    labelText: 'Email Address',
                    hintText: 'Enter email address',
                    icon: Icon(Icons.mail)),
              /*  validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  } else if (!_emailController.text.contains('@')) {
                    return 'Invalid email';
                  } else {
                    return null;
                  }
                },*/
                keyboardType: TextInputType.emailAddress,
                onSaved: (value)=>newUser.email=value as String,

              ),
              SizedBox(
                height: 10,
              ),
              DropdownButtonFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    icon: Icon(Icons.map),
                    labelText: 'County?'),
                items: _countries.map((country) {
                  return DropdownMenuItem(
                    child: Text(country),
                    value: country,
                  );
                }).toList(),
                onChanged: (data) {
                  print('data');
                  setState(() {
                    _selectedCounty = data as String;
                    newUser.country=data as String;
                  });
                },
                value: _selectedCounty,
                //validator: (val) {   return val == null ? 'Please select a county' : null;          },

              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _storyController,
                maxLines: 3,
                inputFormatters: [
                  LengthLimitingTextInputFormatter(100),
                ],
                decoration: InputDecoration(
                  labelText: 'Life Story',
                  hintText: 'Tell us about your self',
                  helperText: 'keep it short, this is just a demo',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value)=>newUser.story=value as String,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                focusNode: _passfocus,
                controller: _passController,
                decoration: InputDecoration(
                  labelText: 'Password',
                  hintText: 'Enter ther password',
                  icon: Icon(Icons.security),
                  suffixIcon: IconButton(
                    icon: Icon(
                        _hidePass ? Icons.visibility : Icons.visibility_off),
                    onPressed: () {
                      setState(() {
                        _hidePass = !_hidePass;
                      });
                    },
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  } else if (_passController.text.length != 8) {
                    return '8 character required for password';
                  } else if (_confirmPassController.text !=
                      _confirmPassController.text) {
                    return 'Password does not match';
                  } else {
                    return null;
                  }
                },
                obscureText: _hidePass,
                maxLength: 8,
              ),
              SizedBox(
                height: 10,
              ),
              TextFormField(
                  controller: _confirmPassController,
                  obscureText: _hidePass,
                  maxLength: 8,
                  decoration: InputDecoration(
                    labelText: 'Confirm Password',
                    hintText: 'Confirm the Password',
                    icon: Icon(Icons.security),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter password';
                    } else if (_confirmPassController.text.length != 8) {
                      return '8 character required for password';
                    } else if (_confirmPassController.text !=
                        _confirmPassController.text) {
                      return 'Password does not match';
                    } else {
                      return null;
                    }
                  }),
              SizedBox(
                height: 10,
              ),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(primary: Colors.lightGreen),
                  onPressed: _submitForm,
                  child: Text(
                    'Submit Form',
                    style: TextStyle(color: Colors.white),
                  ))
            ],
          )),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      _showDialog(name: _nameController.text);
      print('Form is valid');
      print('Name: ${_nameController.text}');
      print('Phone: ${_phoneController.text}');
      print('Email: ${_emailController.text}');
      print('Name: ${_selectedCounty}');
      print('Story: ${_storyController.text}');
    } else {
      _showmessage(message: 'Form is not valid');
    }
  }

/*  String _validateName(String value) {
    final _nameExp = RegExp(r'^[A-Za-z ]+$');
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    } else if (!_nameExp.hasMatch(value)) {
      return 'Please enter alphabetical characters.';
    } else {
      return 'dd';
    }
  }*/

  bool _validatePhone(String input) {
    final _phoneExp = RegExp(r'^\(\d\d\d\)\d\d\d-\d\d\d\d$');
    if (_phoneExp.hasMatch(input)) {
      return true;
    } else {
      return false;
    }
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,
      FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);
  }

  void _showmessage({required String message}) {
    _scaffoldKey.currentState?.showSnackBar(SnackBar(
      duration: Duration(seconds: 5),
      backgroundColor: Colors.red,
      content: Text(
        message,
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
          fontSize: 18.0,
        ),
      ),
    ));
  }

  void _showDialog({required String name}) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Text(
              'Registration successful',
              style: TextStyle(color: Colors.green),
            ),
            content: Text(
              '$name was created successfily',
              style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18.0),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  Navigator.push(context, MaterialPageRoute(builder:
                  (context)=>UserInfoPage(userInfo: newUser,),
                  ),);
                },
                child: Text(
                  'Verified',
                  style: TextStyle(color: Colors.green, fontSize: 18.0),
                ),
              )
            ],
          );
        });
  }
}
