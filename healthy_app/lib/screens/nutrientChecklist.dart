import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy_app/models/medication.dart';
import 'package:healthy_app/models/medication_checklist.dart';
import 'package:healthy_app/models/nutrient.dart';
import 'package:healthy_app/models/nutrient_list.dart';
import 'package:healthy_app/services/auth.dart';
import 'package:healthy_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_icons/flutter_icons.dart';

import 'home/medication_list.dart';

class NutrientChecklist extends StatefulWidget {

  @override
  _NutrientChecklistState createState() => _NutrientChecklistState();
}

class _NutrientChecklistState extends State<NutrientChecklist> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  var userId;

  Future<String> getUid() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    setState(() {
      userId = uid;
    });
    print(uid);
    return uid;
  }

  Widget build(BuildContext context){
    return StreamProvider<List<Medication>>.value(
      value: DatabaseService(uid: userId).medications,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: 2000,
            child: Center(
              child: Column(
                  children: [
                    Padding(padding: EdgeInsets.only(top: 30.0)),
                    StreamProvider<List<Nutrient>>.value(
                      value: DatabaseService(uid: userId).nutrientContent,
                      child: NutrientList(),
                    ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}