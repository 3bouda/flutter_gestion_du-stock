import 'package:flutter/material.dart';
import 'package:bouda/auth/login.dart';
import 'package:bouda/home/family/addfamily.dart';
import 'package:bouda/home/material/borrow.dart';
import 'package:bouda/home/material/listborrow.dart';
import 'package:bouda/home/family/family.dart';
import 'package:bouda/home/family/listfamily.dart';
import 'package:bouda/home/material/listhistory.dart';

Route homeRoutes(RouteSettings setting) {
  late Widget page = const Login();
  switch (setting.name) {
    case '/family':
      page = const Family();
      break;
    case '/borrow':
      page = const Borrow();
      break;
  }
  return MaterialPageRoute<dynamic>(
    builder: (context) {
      return page;
    },
    settings: setting,
  );
}

Route familyRoute(RouteSettings setting) {
  late Widget page = const ListFamily();
  switch (setting.name) {
    case '/addFamily':
      page = const AddFamily();
      break;
    case '/listFamily':
      page = const ListFamily();
      break;
  }
  return MaterialPageRoute<dynamic>(
    builder: (context) {
      return page;
    },
    settings: setting,
  );
  
}
Route borrowRoute(RouteSettings settings) {
  late Widget page = const ListBorrow();
  switch (settings.name) {
    case '/listBorrow':
      page = const ListBorrow();
      break;
    case '/listHistory':
      page = const ListHistory();
      break;
  }
  return MaterialPageRoute<dynamic>(
    builder: (context) {
      return page;
    },
    settings: settings,
  );
  
}


