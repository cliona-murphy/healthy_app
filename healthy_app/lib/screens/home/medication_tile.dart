import 'package:healthy_app/models/medication.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart' show timeDilation;
import 'package:healthy_app/services/database.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MedicationTile extends StatefulWidget {

  final Medication medication;
  final bool taken;
  MedicationTile({ this.medication, this.taken });

  @override
  _MedicationTileState createState() => _MedicationTileState();
}

class _MedicationTileState extends State<MedicationTile> {
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
      isSelected = widget.taken;
    });
    print(isSelected);
  }
  Future<String> getUserid() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    return uid;
  }

  checkIfTaken() async {
    String userId = await getUserid();
    //DatabaseService(uid: userId).checkIfMedTaken(widget.medication.medicineName);
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

  deleteMedication(String medName) async {
    String userId = await getUserid();
    DatabaseService(uid: userId).deleteMedication(medName);
  }

  void selectTime(BuildContext context) async {
    //animate this?
    selectedTime = await showTimePicker(
      context: context,
      initialTime: _time,
      initialEntryMode: TimePickerEntryMode.input,
    );
    timeSelected = true;
    timeString = "${selectedTime.hour}:${selectedTime.minute}";
  }

  showConfirmationDialog() {
    print("fcn being called");
    // set up the buttons
    Widget cancelButton = FlatButton(
      child: Text("Cancel"),
      onPressed:  () {
        Navigator.pop(context);
      },
    );
    Widget continueButton = FlatButton(
        child: Text("Confirm"),
        onPressed:  () {
          if (medName == ""){
            updateTime(widget.medication.medicineName, timeString);
          } else {
            updateDetails(widget.medication.medicineName, medName, timeString);
          }
          Navigator.pop(context);
        }
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Confirm Action"),
      content: Text("Add  to list?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<String> editItem(BuildContext context, String medName, String timeToTake) {
    return showDialog(context: context, builder: (context) {
      return AlertDialog(
        title: Text("Edit details here:"),
        content: Container(
          height: 100,
          child : SingleChildScrollView(
            child: Column(
              children: [
                TextField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: medName,
                  ),
                ),
                Container(
                  child: FlatButton(
                    color: Colors.grey,
                    child: Text("Edit Time"),
                    onPressed: () {
                      selectTime(context);
                    },
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
              deleteMedication(widget.medication.medicineName);
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
              showConfirmationDialog();
              //updateDetails(widget.medication.medicineName, nameController.text, timeController.text);
            },
          ),
        ],
      );
    });
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
                editItem(context, widget.medication.medicineName, widget.medication.timeToTake);
                setState(() {
                });
              },
            ),
            value: isSelected,
             onChanged: (bool newValue) {
              setState(() {
                print(isSelected);
                updateDatabase(newValue, widget.medication.medicineName);
                isSelected = newValue;
          });
        },
      ),
    ),
    );
  }
}