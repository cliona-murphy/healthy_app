import 'package:healthy_app/models/medication.dart';
import 'package:flutter/material.dart';

class MedicationTile extends StatelessWidget {

  final Medication medication;
  MedicationTile({ this.medication });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
        child: ListTile(
          leading: CircleAvatar(
            radius: 25.0,
           // backgroundColor: Colors.brown[medication.medicineName],
          ),
          title: Text(medication.medicineName),
          subtitle: Text('Take at ${medication.timeToTake}'),
        ),
      ),
    );
  }
}