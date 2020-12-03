import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:healthy_app/screens/sign_in.dart';

class Authenticate extends StatefulWidget {
  AuthenticateState createState
      () => AuthenticateState();
}

class AuthenticateState extends State<Authenticate> {
  Widget build(BuildContext context) {
    return Container(
      child: SignIn(),
    );
  }
}