import 'package:flutter/material.dart';
import 'package:healthy_app/services/auth.dart';
import 'package:healthy_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_app/screens/home/userSettings_list.dart';
import 'package:flutter_icons/flutter_icons.dart';

class MedicationTracker extends StatefulWidget {

  @override
  _MedicationTrackerState createState() => _MedicationTrackerState();
}

class _MedicationTrackerState extends State<MedicationTracker> {
  final AuthService _auth = AuthService();

  TextEditingController nameController = TextEditingController();
  TextEditingController timeController = TextEditingController();

  Future <String> addItem(BuildContext context) {
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
                nameController.clear();
                timeController.clear();
                Navigator.pop(context);
              },
            ),
          ],
        );
      });
  }

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Container(
          height: 600,
          child: Center(
            child: Column(
                children: [
                    Padding(padding: EdgeInsets.only(top: 30.0)),
                    Container(
                      padding: const EdgeInsets.fromLTRB(30, 15, 30, 15),
                      child: Text('You have not added anything to this list yet',
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                          color: Colors.blue, fontSize: 20.0),
                    ),
                    ),
                  Container(
                    padding: const EdgeInsets.all(10.0),
                    child: ElevatedButton(
                      onPressed: (){
                        print("button pressed");
                        addItem(context);
                      },
                      child: Text("Add Item"),
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}