import 'package:healthy_app/models/medication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:healthy_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MedicationTile extends StatefulWidget {

  final Medication medication;
  MedicationTile({ this.medication });

  @override
  _MedicationTileState createState() => _MedicationTileState();
}

class _MedicationTileState extends State<MedicationTile> {
  Medication _medication;
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override

  Future<String> getUserid() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    return uid;
  }

  updateDatabase(bool checked, String medName) async{
    String userId = await getUserid();
    DatabaseService(uid: userId).medTaken(medName, checked);
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0.0),
          child: CheckboxListTile(
            title: Text(widget.medication.medicineName,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),),
            subtitle: Text("Take at ${widget.medication.timeToTake}"),
            secondary: IconButton(
              icon: Icon(Icons.edit),
              onPressed: (){
                setState(() {
                });
              },
            ),
            value: timeDilation != 1.0,
             onChanged: (bool value) {
              setState(() {
                updateDatabase(value, widget.medication.medicineName);
                timeDilation = value ? 3.0 : 1.0;
          });
        },
      ),
    ),
    );
  }
}