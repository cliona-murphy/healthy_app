import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:healthy_app/screens/authentication/register.dart';
import 'file:///C:/Users/ClionaM/AndroidStudioProjects/healthy_app/lib/screens/authentication/sign_in.dart';

class Authenticate extends StatefulWidget {

  AuthenticateState createState
      () => AuthenticateState();
}

class AuthenticateState extends State<Authenticate> {

  bool showSignIn = true;
  void toggleView(){
    setState(() => showSignIn = !showSignIn);
  }

  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView: toggleView);
    }
    else {
      return Register(toggleView: toggleView);
    }

  }
}