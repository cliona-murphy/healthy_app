import 'package:flutter/material.dart';
import 'package:healthy_app/services/auth.dart';
import 'package:healthy_app/services/database.dart';
import 'package:healthy_app/shared/ConstantVars.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_app/screens/home/userSettings_list.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Progress extends StatelessWidget {

  final AuthService _auth = AuthService();

  Widget build(BuildContext context){
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().userSettings,
      child: Scaffold(
        backgroundColor: Colors.white,
      ),
    );
  }
}