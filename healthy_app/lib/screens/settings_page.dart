import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String userId = "";

  void initState() {
    super.initState();
    getUid();
  }

  Future<String> getUid() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    setState(() {
      userId = uid;
    });
    print(uid);
    return uid;
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: Firestore.instance.collection('settings').document(userId).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        // var targetIntake = snapshot.data['kcalIntakeTarget'];
        // var targetOutput = snapshot.data['kcalOutputTarget'];
        // var targetWater = snapshot.data['waterIntakeTarget'];
        return new Scaffold(
          appBar: new AppBar(
            title: new Text("Settings"),
          ),
          body: SingleChildScrollView(
            child: Expanded(
              child: Flexible(
                child: ListView(
                  padding: const EdgeInsets.all(8),
                  children: <Widget>[
                    Container(
                      height: 50,
                      color: Colors.amber[600],
                      child: const Center(child: Text('Entry A')),
                    ),
                    Container(
                      height: 50,
                      color: Colors.amber[500],
                      child: const Center(child: Text('Entry B')),
                    ),
                    Container(
                      height: 50,
                      color: Colors.amber[100],
                      child: const Center(child: Text('Entry C')),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
        //return SettingsTile(targetIntake: targetIntake, targetOutput: targetOutput, targetWater: targetWater);
    });
  }
}
