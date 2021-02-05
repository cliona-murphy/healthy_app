import 'package:flutter/material.dart';
import 'package:healthy_app/services/auth.dart';
import 'package:healthy_app/services/database.dart';
import 'package:healthy_app/shared/ConstantVars.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_app/screens/home/userSettings_list.dart';
import 'package:flutter_icons/flutter_icons.dart';

class Progress extends StatelessWidget {

  final AuthService _auth = AuthService();

  Widget build(BuildContext context){
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().userSettings,
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: GestureDetector(
             onTap: () {
               /* Write listener code here */
             print("Calendar View Selected");
             },
             child: Icon(
             Icons.calendar_today_outlined,
            ),
          ),
          title: new Text(getCurrentDate()),
          centerTitle: true,
          actions: <Widget>[
              PopupMenuButton<String>(
                onSelected: choiceAction,
                itemBuilder: (BuildContext context){
                  return ConstantVars.choices.map((String choice){
                    return PopupMenuItem<String>(
                      value: choice,
                      child: Text(choice),
                    );
                  })
                      .toList();
                }
                ,)]
            ,)
            // FlatButton.icon(
            //   icon: Icon(Icons.person),
            //   label: Text("logout"),
            //   onPressed: () async {
            //     await _auth.signOut();
            //   },
            // ),
        //   ],
        // ),
      ),
    );
  }
  void choiceAction(String choice){
    if(choice == ConstantVars.Settings){
      print('Settings');
    }
    else if(choice == ConstantVars.Subscribe){
      print('Subscribe');
    }
    else if(choice == ConstantVars.SignOut){
      _auth.signOut();
      print('SignOut');
    }
  }
  String getCurrentDate(){
    var date = new DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate = "${dateParse.day}/${dateParse.month}/${dateParse.year}";
    return formattedDate;
  }
}