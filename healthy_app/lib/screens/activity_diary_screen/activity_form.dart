import 'package:cupertino_setting_control/cupertino_setting_control.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ActivityForm extends StatefulWidget {
  @override
  _ActivityFormState createState() => _ActivityFormState();
}

class _ActivityFormState extends State<ActivityForm> {

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
                  //onSettingDataRowChange: onSearchAreaChange,
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
                    // DatabaseService(uid: userId).enterUserAge(resultVal.toInt());
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
                    // DatabaseService(uid: userId).enterUserAge(resultVal.toInt());
                  },
                  config: SettingsRowConfiguration(
                      showAsTextField: false,
                      // showTitleLeft: !_titleOnTop,
                      // showTopTitle: _titleOnTop,
                      showAsSingleSetting: false),
                ),
              ]),
        ),
      ),
    );
  }
}
