import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_app/models/food.dart';
import 'package:healthy_app/models/pie_data.dart';
import 'package:provider/provider.dart';
import 'package:charts_flutter/flutter.dart' as charts;

class CalorieCount extends StatefulWidget {

  @override
  _CalorieCountState createState() => _CalorieCountState();
}

class _CalorieCountState extends State<CalorieCount> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  int totalCalories = 0;
  List<charts.Series<PieData, String>> _pieData;
  String userId = "";
  dynamic data;

  Future<dynamic> getData() async {
    print("getData called");
    final DocumentReference document = Firestore.instance.collection("settings")
        .document(userId);

    await document.get().then<dynamic>((DocumentSnapshot snapshot) async {
      setState(() {
        data = snapshot.data;
      });
    });
  }

  void initState() {
    super.initState();
    getUid();
    print("user id within initState = " +userId);
    // getData();
    _pieData = List<charts.Series<PieData, String>>();
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
    await getData();
    return uid;
  }

  generateData(int consumed) {
    getData();
    int kcalTarget;
    int remaining;
    double percentageIntake;
    print("Consumed = " + consumed.toString());
    // if(consumed == 0){
    //   percentageIntake = 1;
    //   remaining = 9;
    // }
   // else {
      if (data != null && data.isNotEmpty) {
        kcalTarget = data['kcalIntakeTarget'];
        remaining = kcalTarget - consumed;
      }
      else {
        remaining = 2000;
      }
      // var piedata = [
      //   new PieData('Consumed', percentageIntake),
      //   new PieData('Remaining', 100 - percentageIntake),
      //   // new PieData('Consumed', 10.10),
      //   // new PieData('Remaining', 20.20),
      // ];
     // percentageIntake = 30;
    percentageIntake = calculatePercentage();
    // }
    // setState(() {
    //   percentageIntake = calculatePercentage();
    // });
    print("target: " + kcalTarget.toString());

    print("percentage intake = " + percentageIntake.toString());
    print(percentageIntake);
    var piedata = [
      new PieData('Consumed', 30),
      new PieData('Remaining', 70.0),
    ];

    _pieData.add(
      charts.Series(
        domainFn: (PieData data, _) => data.activity,
        measureFn: (PieData data, _) => data.time,
        id: 'Time spent',
        data: piedata,
        labelAccessorFn: (PieData row, _) => '${row.activity}',
      ),
    );
    return _pieData;
  }

  double calculatePercentage(){
    int kcalTarget = 2000;
    if (data != null && data.isNotEmpty) {
      kcalTarget = data['kcalIntakeTarget'];
    }
    double percentage = totalCalories/kcalTarget;
        //data['kcalIntakeTarget'];

    print("Percentage "+(percentage*100).toString() + "kcalTarget = "+kcalTarget.toString()+"calories = "+totalCalories.toString());
    setState(() {
      totalCalories = 0;
    });
    return (percentage*100);
  }

  @override
  Widget build(BuildContext context) {
    final foods = Provider.of<List<Food>>(context) ?? [];
    print("userId within calorie count is "+userId);
    if (foods.isNotEmpty) {
      bool notEmpty = true;
      print("foods list is not null");
      print("length of list = " + foods.length.toString());
      //
      for (var food in foods)
        totalCalories += food.calories;
      //print(totalCalories);
      return Container(
        width: 175,
        height: 175,
        //child: Text("test"),
        child: charts.PieChart(
          generateData(500),
          animate: true,
          animationDuration: Duration(seconds: 1),
          // defaultRenderer: new charts.ArcRendererConfig(
          //   arcWidth: 100,
          //   arcRendererDecorators: [
          //     new charts.ArcLabelDecorator(
          //         labelPosition: charts.ArcLabelPosition.inside)
          //   ],
          // ),
        ),
      );
    } else {
      print("foods list is null");
      return Container(
        width: 175,
        height: 175,
        //child: Text("test"),
        child: charts.PieChart(
          generateData(0),
          animate: true,
          animationDuration: Duration(seconds: 1),
          // defaultRenderer: new charts.ArcRendererConfig(
          //   arcWidth: 100,
          //   arcRendererDecorators: [
          //     new charts.ArcLabelDecorator(
          //         labelPosition: charts.ArcLabelPosition.inside)
          //   ],
          // ),
        ),
      );
      // return Container(
      //   height: 80,
      //   width: 300,
      //   padding: const EdgeInsets.fromLTRB(30, 20, 30, 15),
      //   child: Text('Click to log a food',
      //     textAlign: TextAlign.center,
      //     style: new TextStyle(
      //         color: Colors.grey, fontSize: 15.0),
      //   ),
      // );
    }
  }
}
