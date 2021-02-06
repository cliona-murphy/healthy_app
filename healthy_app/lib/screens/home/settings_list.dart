import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:provider/provider.dart';

class SettingsList extends StatefulWidget {
  @override
  _SettingsListState createState() => _SettingsListState();
}

class _SettingsListState extends State<SettingsList> {
  @override
  Widget build(BuildContext context) {

    final userSettings = Provider.of<QuerySnapshot>(context);
    //print(userSettings.documents);
    //if(userSettings == null) return CircularProgressIndicator();
    if(userSettings != null){
      for(var doc in userSettings.documents){
        print(doc.data);
      }
    }
    return Container();
  }
}