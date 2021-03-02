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
        child: RadioListTile(
          // leading: CircleAvatar(
          //   radius: 25.0,
          //  // backgroundColor: Colors.brown[medication.medicineName],
          // ),
          value: medication,
          activeColor: Colors.blue,
          title: Text(medication.medicineName,
          style: TextStyle(color: Colors.black)),
          subtitle: Text('Take at ${medication.timeToTake}',
              style: TextStyle(color: Colors.grey[700])),
        ),
      ),
    );
  }
}