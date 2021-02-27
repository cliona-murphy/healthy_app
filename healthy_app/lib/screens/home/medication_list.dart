import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthy_app/models/medication.dart';

class MedicationList extends StatefulWidget {
  @override
  _MedicationListState createState() => _MedicationListState();
}

class _MedicationListState extends State<MedicationList> {
  @override
  Widget build(BuildContext context) {
    bool foodsNull = false;
    final medications = Provider.of<List<Medication>>(context) ?? [];

    if(medications != null){
      print("medications list is not null");
      print("length of list = " + medications.length.toString());
      return ListView.builder(
        itemCount: medications.length,
        itemBuilder: (context, index) {
          return Text("${medications[index].medicineName.toString()} ${medications[index].timeToTake.toString()} calories");
        },
      );
    } else {
      print("medications list is null");
      return CircularProgressIndicator();
    }
  }
}