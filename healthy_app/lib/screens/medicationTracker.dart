import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy_app/models/medication.dart';
import 'package:healthy_app/models/medication_checklist.dart';
import 'package:healthy_app/services/auth.dart';
import 'package:healthy_app/services/database.dart';
import 'package:healthy_app/shared/loading.dart';
import 'package:provider/provider.dart';
import 'home/medication_list.dart';
import 'package:healthy_app/shared/globals.dart' as globals;

class MedicationTracker extends StatefulWidget {
  //test comment
  @override
  _MedicationTrackerState createState() => _MedicationTrackerState();
}

class _MedicationTrackerState extends State<MedicationTracker> {
  final AuthService _auth = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;

  var userId;
  bool userIdSet = false;
  bool loading = true;

  TextEditingController nameController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  TimeOfDay _time = TimeOfDay.now();
  TimeOfDay selectedTime;
  String timeString;

  void initState(){
    print("init state called");
    super.initState();
    getUid();
    print(userId);
    print("date = " + globals.selectedDate);
    updateBoolean();
  }

  void selectTime(BuildContext context) async {
    //animate this?
      selectedTime = await showTimePicker(
        context: context,
        initialTime: _time,
        initialEntryMode: TimePickerEntryMode.input,
      );
      timeString = "${selectedTime.hour}:${selectedTime.minute}";
      print(timeString);
  }


  Future<String> addItem(BuildContext context) {
    print("Add item called");
      return showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Enter details here:"),
          content: Container(
            height: 135,
            child : SingleChildScrollView(
              child: Column(
                children: [
                  //Text("Food name"),
                  TextField(
                    controller: nameController,
                    decoration: InputDecoration(
                      hintText: "medication/supplement name",
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  Container(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Text("time: ",
                        style: TextStyle(
                        color: Colors.grey[700],
                      ),
                      ),
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(top: 15.0)),
                  Container(
                    child: FlatButton(
                      color: Colors.grey,
                      child: Text("Select Time"),
                      //onPressed: () => selectTime(context),
                      onPressed: () {
                        selectTime(context);
                        print("90 " + timeString);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
          actions: <Widget> [
            MaterialButton(
              elevation: 5.0,
              child: Text("Submit"),
              onPressed: () {
                print("103 " + timeString);
                updateDatabase(nameController.text, timeString);
                nameController.clear();
                timeController.clear();
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
  }

  Future updateDatabase(String medName, String timeToTake) async {
    userId = await getUid();
    DatabaseService(uid: userId).addMedication(medName, timeToTake);
  }

  Future<String> getUid() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    setState(() {
      userId = uid;
    });
    setState(() {
      userIdSet = true;
    });
    print(uid);
    return uid;
  }

  updateBoolean(){
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {
        loading = false;
      });
    });
  }

  Widget build(BuildContext context){
    return StreamProvider<List<Medication>>.value(
      value: DatabaseService(uid: userId).medications,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Container(
            height: 600,
            child: Center(
              child: Column(
                  children: [
                      Padding(padding: EdgeInsets.only(top: 30.0)),
                      StreamProvider<List<MedicationChecklist>>.value(
                          value: DatabaseService(uid: userId).getLoggedMedications(),
                        child: MedicationList(),
                      ),
                      Container(
                        padding: const EdgeInsets.all(10.0),
                        child: ElevatedButton(
                          onPressed: (){
                            addItem(context);
                          },
                          child: Text("Add Item"),
                        ),
                      ),
                  ]),
            ),
          ),
        ),
      ),
    );
  }
}