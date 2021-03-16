import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy_app/screens/home/calorie_count.dart';
import 'package:healthy_app/services/auth.dart';
import 'package:healthy_app/models/food.dart';
import 'package:healthy_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:healthy_app/models/pie_data.dart';

import 'home/food_list.dart';

class Progress extends StatefulWidget {

  @override
  _ProgressState createState() => _ProgressState();
}

class _ProgressState extends State<Progress> {
  final AuthService _auth = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  String userId = "";

  void initState() {
     super.initState();
     getUid();
  }

  Future<String> getUid() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    setState(() {
      userId = uid;
    });
    // setState(() {
    //   userIdSet = true;
    // });
    print(uid);
    return uid;
  }

  Widget build(BuildContext context){
   // final foods = Provider.of<List<Food>>(context) ?? [];
  print("user Id = " +userId);
    return Scaffold(
        backgroundColor: Colors.white,
        body: Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Column(
                children: [
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  Text("Calories"),
                  StreamProvider<List<Food>>.value(
                    value: DatabaseService(uid: userId).allFoods,
                    child: CalorieCount(),
                  )],
              ),
            ),
            Container(
              width: 175,
              height: 100,
            ),
          ],
        ),
    );
  }
}