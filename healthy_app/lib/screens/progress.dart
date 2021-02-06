import 'package:flutter/material.dart';
import 'package:healthy_app/screens/home/settings_list.dart';
import 'package:healthy_app/services/auth.dart';
import 'package:healthy_app/screens/home/settings_list.dart';

class Progress extends StatelessWidget {

  final AuthService _auth = AuthService();

  Widget build(BuildContext context){
    return Scaffold(
        backgroundColor: Colors.white,
        body: SettingsList(),
    );
  }
}