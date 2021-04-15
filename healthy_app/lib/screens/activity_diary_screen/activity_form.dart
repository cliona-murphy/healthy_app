import 'package:cupertino_setting_control/cupertino_setting_control.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:healthy_app/services/database.dart';

class ActivityForm extends StatefulWidget {
  @override
  _ActivityFormState createState() => _ActivityFormState();
}

class _ActivityFormState extends State<ActivityForm> {

  String activityType = 'Walking';
  double distance = 0;
  double duration = 0;
  String error = "";

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

  void onSearchAreaChange(String data) {
    setState(() {
      activityType = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Log your activity"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(left: 10.0),
                  child: Text(
                    "What type of activity did you do?",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ),
                 Padding(padding: const EdgeInsets.only(top: 10.0),),
                 SettingRow(
                  rowData: SettingsDropDownConfig(
                      title: 'Activity',
                      initialKey: 'walking',
                      choices: {
                        'Walking': 'Walking',
                        'Running': 'Running',
                        'Cycling': 'Cycling',
                        'Swimming': 'Swimming',
                      }),
                  onSettingDataRowChange: onSearchAreaChange,
                  config: SettingsRowConfiguration(
                      showAsTextField: false,
                     // showTitleLeft: !_titleOnTop,
                     // showTopTitle: _titleOnTop,
                      showAsSingleSetting: false),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: Text(
                    "What distance did you do?",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 10.0),),
                SettingRow(
                  rowData: SettingsSliderConfig(
                    title: 'Distance',
                    from: 0,
                    to: 100,
                    initialValue: 0,
                    justIntValues: true,
                    unit: ' km',
                  ),
                  onSettingDataRowChange: (double resultVal) {
                    setState(() {
                      distance = resultVal;
                    });
                  },
                  config: SettingsRowConfiguration(
                      showAsTextField: false,
                      // showTitleLeft: !_titleOnTop,
                      // showTopTitle: _titleOnTop,
                      showAsSingleSetting: false),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 10.0),
                  child: Text(
                    "How long did it take you?",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ),
                Padding(padding: const EdgeInsets.only(top: 10.0),),
                SettingRow(
                  rowData: SettingsSliderConfig(
                    title: 'Duration',
                    from: 0,
                    to: 120,
                    initialValue: 0,
                    justIntValues: true,
                    unit: ' minutes',
                  ),
                  onSettingDataRowChange: (double resultVal) {
                    setState(() {
                      duration = resultVal;
                    });
                  },
                  config: SettingsRowConfiguration(
                      showAsTextField: false,
                      // showTitleLeft: !_titleOnTop,
                      // showTopTitle: _titleOnTop,
                      showAsSingleSetting: false),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 40.0, top: 10.0),
                  child: Text(
                    error,
                    style: TextStyle(
                      color: Colors.red,
                    ),
                  ),
                ),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10.0),
                      width: 100,
                      child: ElevatedButton(
                        onPressed: (){
                          if (distance == 0 || duration == 0){
                            setState(() {
                              error = "Please supply valid values for all fields.";
                            });
                          } else {
                            DatabaseService(uid: userId).addActivity(activityType, distance, duration);
                            Navigator.pop(context, "test");
                          }
                        },
                        child: Text("Save"),
                      ),
                    ),
                  ],
                ),
              ]),
        ),
      ),
    );
  }
}
