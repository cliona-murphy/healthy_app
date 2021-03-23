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

  deleteMedication(String medName) async {
    String userId = await getUserid();
    DatabaseService(uid: userId).deleteMedication(medName);
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
                  // child: Column(
                  //   children: [
                  //     InkWell(
                  //       //onTap: () => _selectTime(context)
                  //     ),
                  child: TextField(
                    controller: timeController,
                    decoration: InputDecoration(
                      hintText: timeToTake,
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
            //elevation: 5.0,
            color: Colors.red,
            //child: Text("Delete Item"),
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
              updateDetails(widget.medication.medicineName, nameController.text, timeController.text);
              nameController.clear();
              timeController.clear();
              Navigator.pop(context);
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
           // value: timeDilation != 1.0,
            value: isSelected,
             onChanged: (bool newValue) {
              setState(() {
                print(isSelected);
                updateDatabase(newValue, widget.medication.medicineName);
                isSelected = newValue;
                //widget.taken = false;
                //timeDilation = value ? 3.0 : 1.0;

          });
        },
      ),
    ),
    );
  }
}