import 'package:flutter/material.dart';
import 'package:healthy_app/services/auth.dart';
class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title : Text("Home"),
        backgroundColor: Colors.grey,
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text("logout"),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
        ],
      ),
    );
  }
}