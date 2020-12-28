import 'package:flutter/material.dart';
import 'package:healthy_app/services/auth.dart';
import 'package:healthy_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_app/screens/home/userSettings_list.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

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
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Progress',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.no_food),
          label: 'Food',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.directions_run_outlined),
          label: 'Activity',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.wb_sunny),
          label: 'Nutrients',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.check),
          label: 'Meds',
        ),
      ],
     ),
    ),
    );
  }
}