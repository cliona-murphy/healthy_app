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

  void initState(){
    print("init state called");
    super.initState();
    getUid();
    print(userId);
    print("date = " + globals.selectedDate);
    updateBoolean();
  }


  Future<String> addItem(BuildContext context) {
    print("Add item called");
      return showDialog(context: context, builder: (context) {
        return AlertDialog(
          title: Text("Enter details here:"),
          content: Container(
            height: 100,
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
                  Container(
                    // child: Column(
                    //   children: [
                    //     InkWell(
                    //       //onTap: () => _selectTime(context)
                    //     ),
                        child: TextField(
                        controller: timeController,
                        decoration: InputDecoration(
                          hintText: "time to be taken at",
                        ),
                      ),
                   // ]),
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
                updateDatabase(nameController.text, timeController.text);
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
    // rebuildAllChildren(context);
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