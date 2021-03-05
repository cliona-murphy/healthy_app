import 'package:healthy_app/models/medication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;

class MedicationTile extends StatefulWidget {

  final Medication medication;
  MedicationTile({ this.medication });

  @override
  _MedicationTileState createState() => _MedicationTileState();
}

class _MedicationTileState extends State<MedicationTile> {
  Medication _medication;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: CheckboxListTile(
            title: Text(widget.medication.medicineName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
            subtitle: Text("Take at ${widget.medication.timeToTake}"),
            value: timeDilation != 1.0,
             onChanged: (bool value) {
              setState(() {
                print(value);
                timeDilation = value ? 3.0 : 1.0;
          });
        },
      ),
    ),
    );
  }
}