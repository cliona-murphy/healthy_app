import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_app/models/food.dart';
import 'package:healthy_app/models/pie_data.dart';
import 'package:healthy_app/shared/loading.dart';
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
  bool loading = true;

  updateBoolean(){
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        loading = false;
      });
    });
  }

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
    updateBoolean();
    getUid();
    print("user id within initState = " + userId);
    getData();
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
    double percentageIntake;
    if(consumed == 0){
      percentageIntake = .1;
    }
    else {
      percentageIntake = calculatePercentage();
    }

    print("percentage intake = " + percentageIntake.toString());
    print(percentageIntake);
    var piedata = [
      new PieData('Consumed', percentageIntake),
      new PieData('Remaining', 100 - percentageIntake),
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

  double calculatePercentage() {
    int kcalTarget;
    //getData();
    if (data != null) {
      kcalTarget = data['kcalIntakeTarget'];
      print("target = "+kcalTarget.toString());
    } else {
      kcalTarget = 2000;
    }
    double percentage = totalCalories / kcalTarget;
    //data['kcalIntakeTarget'];

    print("Percentage " + (percentage * 100).toString() + "kcalTarget = " +
        kcalTarget.toString() + "calories = " + totalCalories.toString());
    setState(() {
      totalCalories = 0;
    });
    return (percentage * 100);
  }

  @override
  Widget build(BuildContext context) {
    final foods = Provider.of<List<Food>>(context) ?? [];
    print("userId within calorie count is " + userId);
    if (foods.isNotEmpty) {
      bool notEmpty = true;
      print("foods list is not null");
      print("length of list = " + foods.length.toString());
      //
      for (var food in foods)
        totalCalories += food.calories;

      return Container(
        width: 175,
        height: 175,
        //child: Text("test"),
        child: charts.PieChart(
        generateData(500),
        animate: true,
        animationDuration: Duration(milliseconds: 500),
          ),
      );
    } else {
      print("foods list is null");
      return loading ? Loading() : Container(
        width: 175,
        height: 175,
        //child: Text("test"),
        child: charts.PieChart(
          generateData(0),
          animate: true,
          animationDuration: Duration(milliseconds: 500),
        ),
      );
    }
  }
}