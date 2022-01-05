import 'package:flutter/material.dart';
import 'package:bouda/models/user.dart';
import 'package:bouda/services/auth/auth_service.dart';
import 'package:bouda/services/utility/dialog.dart';
import 'package:regexpattern/regexpattern.dart';

class Register extends StatelessWidget {
  const Register({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Register'),
        ),
        body: const MyRegisterState());
  }
}

class MyRegisterState extends StatefulWidget {
  const MyRegisterState({Key? key}) : super(key: key);
  @override
  State<MyRegisterState> createState() => _MyRegisterState();
}

class _MyRegisterState extends State<MyRegisterState> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String? username;
  String? email;
  String? password;
  @override
  Widget build(BuildContext mycontext) {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter username',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              setState(() {
                username = value;
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(
              hintText: 'Enter Email',
            ),
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              if (!value.isEmail()) {
                return 'Please enter valid email';
              }
              setState(() {
                email = value;
              });
            },
          ),
          TextFormField(
            decoration: const InputDecoration(hintText: 'Enter Password'),
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            validator: (String? value) {
              if (value == null || value.isEmpty) {
                return 'Please enter some text';
              }
              setState(() {
                password = value;
              });
            },
          ),
          ElevatedButton(
            child: const Text('Create Account'),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                bool state = await AuthService.register(User(
                    username: username!, email: email!, password: password!));
                if (state) {
                  await MyDialog.fullDialog(context, "ACCOUNT CREATED");
                  Navigator.pushNamed(context, "/login");
                  return;
                }
                MyDialog.fullDialog(context, "ACCOUNT ALEARDY EXIST");
              }
            },
          ),
          ElevatedButton(
            child: const Text('login'),
            onPressed: () async {
              Navigator.pushNamed(context, '/login');
            },
          )
        ],
      ),
    );
  }
}
