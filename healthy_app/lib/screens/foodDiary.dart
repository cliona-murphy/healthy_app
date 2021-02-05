import 'package:flutter/material.dart';
import 'package:healthy_app/services/auth.dart';
import 'package:healthy_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_app/screens/home/userSettings_list.dart';
import 'package:flutter_icons/flutter_icons.dart';

class FoodDiary extends StatefulWidget {

  @override
  _FoodDiaryState createState() => _FoodDiaryState();
}

class _FoodDiaryState extends State<FoodDiary> {
  final AuthService _auth = AuthService();

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: new Container (
          padding: const EdgeInsets.all(30.0),
          color: Colors.white,
          child: new Container(
              child: new Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 0.0)),
                    Text('Breakfast',
                      style: new TextStyle(
                          color: Colors.blue, fontSize: 20.0),),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    TextField(
                      decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          hintText: 'What did you eat for breakfast?'
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    Text('Lunch',
                      style: new TextStyle(
                          color: Colors.blue, fontSize: 20.0),),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    TextField(
                      decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          hintText: 'What did you eat for lunch?'
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    Text('Dinner',
                      style: new TextStyle(
                          color: Colors.blue, fontSize: 20.0),),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    TextField(
                      decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          hintText: 'What did you eat for dinner?'
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    Text('Snacks',
                      style: new TextStyle(
                          color: Colors.blue, fontSize: 20.0),),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    TextField(
                      decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          hintText: 'What snacks did you have?'
                      ),
                    ),
                    Padding(padding: EdgeInsets.only(top: 20.0)),
                    Text('Water',
                      style: new TextStyle(
                          color: Colors.blue, fontSize: 20.0),),
                    Padding(padding: EdgeInsets.only(top: 10.0)),
                    TextField(
                      decoration: InputDecoration(
                          border: new OutlineInputBorder(
                            borderRadius: new BorderRadius.circular(25.0),
                            borderSide: new BorderSide(),
                          ),
                          fillColor: Colors.blue, //not working for some reason
                          hintText: 'How much water did you drink?'
                      ),
                    ),
                  ]),
          ),
        ),
      ),
    );
  }
}