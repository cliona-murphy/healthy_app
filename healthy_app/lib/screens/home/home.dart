import 'package:flutter/material.dart';
import 'package:healthy_app/services/auth.dart';
import 'package:healthy_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_app/screens/home/userSettings_list.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:healthy_app/shared/navbar.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();
  final NavBar _bar = NavBar();

  List<Widget> widgetOptions = <Widget>[
    Text('Progress'),
    Text('Food Diary'),
    Text('Activity Diary'),
    Text('Nutrient Checklist'),
    Text('Medications'),
  ];

  Widget build(BuildContext context){
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().userSettings,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title : Text("Home"),
          backgroundColor: Colors.grey,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.person),
              label: Text("logout"),
              onPressed: () async {
                await _auth.signOut();
              },
            ),
          ],
        ),
        body: UserSettingsList(),
        bottomNavigationBar: NavBar(),
    ),
    );
  }
}