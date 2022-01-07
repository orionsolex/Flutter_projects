import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RegisterFormDemo extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterFormDemo> {
  bool _hidePass = true;
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _storyController = TextEditingController();
  final _passController = TextEditingController();
  final _confirmPassController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _storyController.dispose();
    _passController.dispose();
    _confirmPassController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Form'),
        centerTitle: true,
      ),
      body: Form(
          child: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          TextField(
            controller: _nameController,
            decoration: InputDecoration(
              labelText: 'Full Name *',
              hintText: 'What do people call you?',
              prefixIcon: Icon(Icons.person),
              suffixIcon: Icon(
                Icons.delete_outline,
                color: Colors.red,
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
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _phoneController,
            decoration: InputDecoration(
              labelText: 'Phone Number',
              hintText: 'Where can we reach you',
              helperText: 'Phone format: (xxx)xxx-xxxx',
              prefixIcon: Icon(Icons.call),
              suffixIcon: Icon(
                Icons.delete_outline,
                color: Colors.red,
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
              FilteringTextInputFormatter.digitsOnly,
            ],
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
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _storyController,
            maxLines: 3,
            decoration: InputDecoration(
              labelText: 'Life Story',
              hintText: 'Tell us about your self',
              helperText: 'keep it short, this is just a demo',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TextFormField(
            controller: _passController,
            decoration: InputDecoration(
              labelText: 'Password',
              hintText: 'Enter ther password',
              icon: Icon(Icons.security),
              suffixIcon: IconButton(
                icon: Icon(_hidePass ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _hidePass = !_hidePass;
                  });
                },
              ),
            ),
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
          ),
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
    print('Name: ${_nameController.text}');
    print('Phone: ${_phoneController.text}');
    print('Email: ${_emailController.text}');
    print('Story: ${_storyController.text}');
  }
}
