import 'package:flutter/material.dart';
import 'package:healthy_app/services/auth.dart';
import 'package:healthy_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_icons/flutter_icons.dart';

class NutrientChecklist extends StatelessWidget {

  final AuthService _auth = AuthService();

  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.white,
        body: Text("This is the nutrient checklist"),
    );
  }
}