import 'package:flutter/material.dart';
import 'package:bouda/models/user.dart';
import 'package:bouda/services/auth/auth_service.dart';
import 'package:bouda/services/utility/dialog.dart';
import 'package:regexpattern/regexpattern.dart';

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Login"),
        ),
        body: const MyLoginState());
  }
}

class MyLoginState extends StatefulWidget {
  const MyLoginState({Key? key}) : super(key: key);
  @override
  State<MyLoginState> createState() => _MyLoginState();
}

class _MyLoginState extends State<MyLoginState> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
            child: const Text('Login'),
            onPressed: () async {
              if (_formKey.currentState!.validate()) {
                final bool state =
                    await AuthService.login(User.instance(email!, password!));
                if (state) {
                  Navigator.pushNamed(context, "/home");
                  return;
                }
                await MyDialog.fullDialog(context, "BAD INFORMATION");
              }
            },
          ),
          ElevatedButton(
            child: const Text('No account'),
            onPressed: () async {
              Navigator.pushNamed(context, '/register');
            },
          )
        ],
      ),
    );
  }
}