import 'dart:core';
import 'package:flutter/material.dart';
import 'package:healthy_app/screens/home/home.dart';
import 'file:///C:/Users/ClionaM/AndroidStudioProjects/healthy_app/lib/screens/home/wrapper.dart';
import 'package:healthy_app/services/auth.dart';
import 'package:healthy_app/models/user.dart';
import 'package:provider/provider.dart';

import 'models/item.dart';

Future<dynamic> myBackgroundMessageHandler(Map<String, dynamic> message) {
  if (message.containsKey('data')) {
    // Handle data message
    final dynamic data = message['data'];
  }

  if (message.containsKey('notification')) {
    // Handle notification message
    final dynamic notification = message['notification'];
  }
  final Map<String, Item> _items = <String, Item>{};
  Item _itemForMessage(Map<String, dynamic> message) {
    final dynamic data = message['data'] ?? message;
    final String itemId = data['id'];
    final Item item = _items.putIfAbsent(itemId, () => Item(itemId: itemId))
      ..matchteam = data['matchteam']
      ..score = data['score'];
    return item;
  }
  // Or do other work.
}


void main() {
  runApp(myApp());
}
class myApp extends StatelessWidget {
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
           home: Home(),
          // home: Wrapper(),
      ),
    );
  }
}

