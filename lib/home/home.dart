import 'package:flutter/material.dart';
import 'package:bouda/services/auth/auth_service.dart';
import 'package:bouda/services/utility/router.dart';

class MyHome extends StatefulWidget {
  const MyHome({Key? key}) : super(key: key);
  @override
  State<MyHome> createState() => _MyHome();
}

class _MyHome extends State<MyHome> {
  final GlobalKey<NavigatorState> key = GlobalKey();
  int myindex = 0;

  @override
  void initState() {
    super.initState();
    AuthService.isLogged().then((value) => {
          if (!value) {Navigator.pushNamed(context, "/login")}
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Association Jeunes Science"),
      ),
      body: Navigator(
        key: key,
        initialRoute: '/family',
        onGenerateRoute: homeRoutes,
      ),
      bottomNavigationBar:
          BottomNavigationBar(items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.account_balance_outlined),
          label: 'Family',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.production_quantity_limits),
          label: 'Borrowed Material',
        ),
      ], currentIndex: myindex, onTap: _onItemTapped),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      myindex = index;
      switch (index) {
        case 0:
          key.currentState!.pushNamed('/family');
          break;
        case 1:
          key.currentState!.pushNamed('/borrow');
          break;
      }
    });
  }
}
