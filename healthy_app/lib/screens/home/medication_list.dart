import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:healthy_app/models/medication.dart';

import 'medication_tile.dart';

class MedicationList extends StatefulWidget {
  @override
  _MedicationListState createState() => _MedicationListState();
}

class _MedicationListState extends State<MedicationList> {
  @override
  Widget build(BuildContext context) {
    bool foodsNull = false;
    final medications = Provider.of<List<Medication>>(context) ?? [];

    if(medications.isNotEmpty){
      print("medications list is not empty");
      print(medications);
      print("length of list = " + medications.length.toString());
      return ListView.builder(
        shrinkWrap: true,
        itemCount: medications.length,
        itemBuilder: (context, index) {
          //return Text("${medications[index].medicineName.toString()} ${medications[index].timeToTake.toString()} calories");
          return MedicationTile(medication: medications[index]);
        },
      );
    } else {
      print("medications list is null");
      return Container(
        height: 300,
        width: 300,
        padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
        child: Text('You have not added anything to this list yet',
          textAlign: TextAlign.center,
          style: new TextStyle(
          color: Colors.blue, fontSize: 20.0),
        ),
      );
    }
  }
}