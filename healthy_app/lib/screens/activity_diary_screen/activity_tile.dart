import 'package:healthy_app/models/activity.dart';
import 'package:healthy_app/models/medication.dart';
import 'package:flutter/material.dart';
import 'package:healthy_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ActivityTile extends StatefulWidget {

  final Activity activity;
  ActivityTile({ this.activity });

  @override
  _ActivityTileState createState() => _ActivityTileState();
}

class _ActivityTileState extends State<ActivityTile> {
  Medication _medication;
  final FirebaseAuth auth = FirebaseAuth.instance;
  // timeDilation = 1.0;
  TextEditingController nameController = TextEditingController();
  TextEditingController timeController = TextEditingController();
  bool isSelected = true;
  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay selectedTime;
  String timeString;
  bool timeSelected = false;
  String medName = "";

  void initState(){
    super.initState();
    setState(() {
      //isSelected = widget.taken;
    });
  }
  Future<String> getUserid() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    return uid;
  }

  updateDatabase(bool checked, String medName) async {
    String userId = await getUserid();
    DatabaseService(uid: userId).medTaken(medName, checked);
  }

  updateDetails(String originalMedName, String newMedName, String timeToTake) async {
    String userId = await getUserid();
    DatabaseService(uid: userId).updateMedicationDetails(originalMedName, newMedName, timeToTake);
  }
  updateTime(String medName, String timeToTake) async {
    String userId = await getUserid();
    DatabaseService(uid: userId).updateMedicationTime(medName, timeToTake);
  }

  deleteActivity(String activityType) async {
    String userId = await getUserid();
    DatabaseService(uid: userId).deleteMedication(medName);
  }

  Future<String> editItem(BuildContext context, String medName, String timeToTake) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Edit "+medName+" details here:"),
        content: Container(
          height: 60,
          child : SingleChildScrollView(
            child: Column(
              children: [
                Padding(padding: EdgeInsets.only(top: 15.0),),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Container(
                    child: FlatButton(
                      color: Colors.grey,
                      child: Text("Edit Time"),
                      onPressed: () {
                        //selectTime(context);
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        actions: <Widget> [
          IconButton(
            icon: Icon(Icons.delete),
            color: Colors.red,
            onPressed: () {
              //deleteMedication(widget.medication.medicineName);
              nameController.clear();
              timeController.clear();
              Navigator.pop(context);
            },
          ),
          MaterialButton(
            elevation: 5.0,
            child: Text("Update"),
            onPressed: () {
              setState(() {
                medName = nameController.text;
              });
              nameController.clear();
              timeController.clear();
              Navigator.pop(context);
              //updateDetails(widget.medication.medicineName, nameController.text, timeController.text);
            },
          ),
        ],
      );
    });
  }

  String checkActivityType(String activityType) {
    String string = "";
    switch (activityType){
      case 'Walking':
        setState(() {
          string = "walked";
        });
        break;
      case 'Running':
        setState(() {
          string = "ran";
        });
        break;
      case 'Cycling':
        setState(() {
          string = "cycled";
        });
        break;
      case 'Swimming':
        setState(() {
          string = "swam";
        });
        break;
    }
    return string;
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child:  Card(
        clipBehavior: Clip.antiAlias,
        child: Column(
          children: [
            ListTile(
              leading: Icon(Icons.arrow_drop_down_circle),
              title: Text(widget.activity.activityType.toString()),
              subtitle: Text("${widget.activity.calories.toInt()} calories",
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            Padding(
              padding: EdgeInsets.fromLTRB(10, 0, 0, 0),
              child: Text(
                'You ${checkActivityType(widget.activity.activityType)} ${widget.activity.distance.toInt()} km in ${widget.activity.duration.toInt()} minutes',
                style: TextStyle(color: Colors.black.withOpacity(0.6)),
              ),
            ),
            ButtonBar(
              alignment: MainAxisAlignment.center,
              children: [
                FlatButton(
                  textColor: const Color(0xFF6200EE),
                  onPressed: () {
                    // Perform some action
                  },
                  child: const Text('EDIT'),
                ),
                FlatButton(
                  textColor: const Color(0xFF6200EE),
                  onPressed: () {
                    // Perform some action
                  },
                  child: const Text('DELETE'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}