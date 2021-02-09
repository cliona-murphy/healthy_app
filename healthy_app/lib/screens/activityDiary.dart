import 'package:flutter/material.dart';
import 'package:healthy_app/services/auth.dart';
import 'package:healthy_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_app/screens/home/userSettings_list.dart';
import 'package:flutter_icons/flutter_icons.dart';

class ActivityDiary extends StatelessWidget {

  final AuthService _auth = AuthService();

  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.white,
        body: Text("This is the activity diary"),
    );
  }
}