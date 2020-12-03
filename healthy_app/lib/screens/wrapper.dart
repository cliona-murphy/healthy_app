import 'package:flutter/material.dart';
import 'package:healthy_app/screens/authentication/authenticate.dart';
import 'package:healthy_app/screens/home/home.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //return either home or authenticate widget
    return Authenticate();
  }
}
