import 'dart:core';

import 'package:flutter/material.dart';
import 'package:healthy_app/models/arguments.dart';
import 'package:healthy_app/screens/home/home.dart';
import 'package:healthy_app/screens/wrapper.dart';
import 'package:healthy_app/services/auth.dart';
import 'package:healthy_app/models/user.dart';
import 'package:provider/provider.dart';
import 'package:healthy_app/shared/globals.dart' as globals;

void main() {
  runApp(myApp());
}
class myApp extends StatelessWidget {
  Route<dynamic> _getRoute(RouteSettings settings) {
    if (settings.name == '/second') {
      var date = settings.arguments.toString();
      globals.selectedDate = date;
      return _buildRoute(settings, new Home());
    }
    return null;
  }

  MaterialPageRoute _buildRoute(RouteSettings settings, Widget builder) {
    return new MaterialPageRoute(
      settings: settings,
      builder: (ctx) => builder,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamProvider<User>.value(
      value: AuthService().user,
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
           initialRoute: '/',
           routes: {
            '/second': (context) => Home(),
           },
           onGenerateRoute: (settings) {
            print("settings name = " + settings.name.toString());
            final Arguments arg = settings.arguments as Arguments;
            bool argReturned = false;
            if(arg != null) {
              print("arg = " + settings.arguments.toString());
              argReturned = true;
            }
            print("arg be null");
            return argReturned ? MaterialPageRoute(
              builder: (context) {
                return Home(
                  date: arg.date.toString(),
                );
              },
            ) : MaterialPageRoute(
              builder: (context) {
                return Home();
              },
            );
           },
           home: Wrapper(),
      ),
    );
  }
}

