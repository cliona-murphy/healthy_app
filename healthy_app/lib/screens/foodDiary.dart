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

  Widget build(BuildContext context){
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().userSettings,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Text("This is the food diary"),
      ),
    );
  }
}