import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy_app/models/medication.dart';
import 'package:healthy_app/models/medication_checklist.dart';
import 'package:healthy_app/screens/activity_diary_screen/activity_list.dart';
import 'package:healthy_app/screens/medication_tracker_screen/medication_list.dart';
import 'package:healthy_app/services/auth.dart';
import 'package:healthy_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:flushbar/flushbar.dart';

import 'activity_form.dart';

class ActivityDiary extends StatefulWidget {

  @override
  _ActivityDiaryState createState() => _ActivityDiaryState();
}

class _ActivityDiaryState extends State<ActivityDiary> {
  final AuthService _auth = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String userId = "";

  void initState(){
    super.initState();
    getUid();
  }

  Future<String> getUid() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    setState(() {
      userId = uid;
    });
    return uid;
  }

  renderActivityForm(BuildContext context) async {
    final result = await
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ActivityForm(),
        ));
    if(result.isNotEmpty){
      setState(() {
        showSnackBar();
        // selectedDate = result;
        // newDate = true;
        // globals.selectedDate = selectedDate;
      });
    }
  }

  showSnackBar(){
    return Flushbar(
      duration: Duration(seconds: 1),
      flushbarPosition: FlushbarPosition.TOP,
      title: 'Success',
      message: "Your activity was successfully logged!",
    )..show(context);
  }

  void addItem(BuildContext context){
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => ActivityForm(),
    //     ));
    renderActivityForm(context);
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
                      child: ActivityList(),
                    ),
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      child: ElevatedButton(
                        onPressed: (){
                          addItem(context);
                          //addItem(context);
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