import 'package:flutter/material.dart';
import 'package:bouda/auth/register.dart';
import 'package:bouda/home/home.dart';
import 'auth/login.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: new ThemeData(scaffoldBackgroundColor: Colors.amber[50]),
      initialRoute: '/login',
      routes: {
        '/': (context) => const MyHome(),
        '/home': (context) => const MyHome(),
        '/login': (context) => const Login(),
        '/register': (context) => const Register(),
      },
    );
  }
}
