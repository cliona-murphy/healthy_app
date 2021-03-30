import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cupertino_setting_control/cupertino_setting_control.dart';
import 'package:healthy_app/services/database.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  String userId = "";
  bool _chatResult = true;
  String _searchAreaResult = 'Germany';
  bool _titleOnTop = false;


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

  void onChatSettingChange(bool data) {
    setState(() {
      _chatResult = data;
    });
  }

  void onSearchAreaChange(String data) {
    setState(() {
      _searchAreaResult = data;
    });
    DatabaseService(uid: userId).enterUserCountry(_searchAreaResult);
  }

  @override
  Widget build(BuildContext context) {
    final titleOnTopSwitch = SettingRow(
        rowData: SettingsYesNoConfig(
            initialValue: _titleOnTop, title: 'Title on top'),
        config: const SettingsRowConfiguration(showAsSingleSetting: true),
        onSettingDataRowChange: (newVal) => setState(() {
          _titleOnTop = newVal;
        }));

    final profileSettingsTile = new Material(
      color: Colors.transparent,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
              padding: EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
              child: const Text(
                'Profile',
                style: TextStyle(
                  color: CupertinoColors.systemBlue,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
          new SettingRow(
            rowData: SettingsDropDownConfig(
                title: 'User Area',
                initialKey: _searchAreaResult,
                choices: {
                  'Ireland': 'Ireland',
                  'United Kingdom': 'United Kingdom',
                }),
            onSettingDataRowChange: onSearchAreaChange,
            config: SettingsRowConfiguration(
                showAsTextField: false,
                showTitleLeft: !_titleOnTop,
                showTopTitle: _titleOnTop,
                showAsSingleSetting: false),
          ),
          SizedBox(height: _titleOnTop ? 10.0 : 0.0),
          new SettingRow(
            rowData: SettingsSliderConfig(
              title: 'Age',
              from: 18,
              to: 120,
              initialValue: 20,
              justIntValues: true,
              unit: ' years',
            ),
            onSettingDataRowChange: (double resultVal) {
              DatabaseService(uid: userId).enterUserAge(resultVal);
            },
            config: SettingsRowConfiguration(
                showAsTextField: false,
                showTitleLeft: !_titleOnTop,
                showTopTitle: _titleOnTop,
                showAsSingleSetting: false),
          ),
          SizedBox(height: _titleOnTop ? 10.0 : 0.0),
          new SettingRow(
            rowData: SettingsSliderConfig(
              title: 'Weight',
              from: 40,
              to: 120,
              initialValue: 50,
              justIntValues: true,
              unit: ' kg',
            ),
            onSettingDataRowChange: (double resultVal) {
              DatabaseService(uid: userId).enterUserWeight(resultVal);
            },
            config: SettingsRowConfiguration(
                showAsTextField: false,
                showTitleLeft: !_titleOnTop,
                showTopTitle: _titleOnTop,
                showAsSingleSetting: false),
          ),
          SizedBox(height: _titleOnTop ? 10.0 : 0.0),
        ],
      ),
    );

    final accountSettingsTile = new Material(
      color: Colors.transparent,
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(
              padding: EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
              child: const Text(
                'Account',
                style: TextStyle(
                  color: CupertinoColors.systemBlue,
                  fontSize: 15.0,
                  fontWeight: FontWeight.bold,
                ),
              )),
          SizedBox(height: _titleOnTop ? 10.0 : 0.0),
          new SettingRow(
            rowData: SettingsSliderConfig(
              title: 'Daily Calorie Intake Target',
              from: 1500,
              to: 5000,
              initialValue: 2500,
              justIntValues: true,
              unit: ' kcal',
            ),
            onSettingDataRowChange: (double resultVal) {},
            config: SettingsRowConfiguration(
                showAsTextField: false,
                showTitleLeft: !_titleOnTop,
                showTopTitle: _titleOnTop,
                showAsSingleSetting: false),
          ),
          SizedBox(height: _titleOnTop ? 10.0 : 0.0),
          new SettingRow(
            rowData: SettingsSliderConfig(
              title: 'Daily Calorie Output Target',
              from: 1000,
              to: 4000,
              initialValue: 2000,
              justIntValues: true,
              unit: ' kcal',
            ),
            onSettingDataRowChange: (List<double> resultVals) {},
            config: SettingsRowConfiguration(
                showAsTextField: false,
                showTitleLeft: !_titleOnTop,
                showTopTitle: _titleOnTop,
                showAsSingleSetting: false),
          ),
          SizedBox(height: _titleOnTop ? 10.0 : 0.0),
          new SettingRow(
            rowData: SettingsSliderConfig(
              title: 'Daily Water Intake Target',
              from: 2,
              to: 5,
              initialValue: 2,
              justIntValues: true,
              unit: ' litres',
            ),
            onSettingDataRowChange: (List<double> resultVals) {},
            config: SettingsRowConfiguration(
                showAsTextField: false,
                showTitleLeft: !_titleOnTop,
                showTopTitle: _titleOnTop,
                showAsSingleSetting: false),
          ),
        ],
      ),
    );

    final modifyProfileTile = new Material(
        color: Colors.transparent,
        child: new Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const Padding(
                  padding: EdgeInsets.fromLTRB(25.0, 5.0, 25.0, 5.0),
                  child: const Text(
                    'Profile Options',
                    style: TextStyle(
                      color: CupertinoColors.systemBlue,
                      fontWeight: FontWeight.bold,
                      fontSize: 15.0,
                    ),
                  )),
              SettingRow(
                rowData: SettingsButtonConfig(
                  title: 'Delete Profile',
                  tick: true,
                  functionToCall: () {},
                ),
                style: const SettingsRowStyle(
                    backgroundColor: CupertinoColors.lightBackgroundGray),
                config: SettingsRowConfiguration(
                    showAsTextField: false,
                    showTitleLeft: !_titleOnTop,
                    showTopTitle: _titleOnTop,
                    showAsSingleSetting: false),
              )
            ]));

    final List<Widget> widgetList = [
      titleOnTopSwitch,
      const SizedBox(height: 15.0),
      profileSettingsTile,
      const SizedBox(height: 15.0),
      accountSettingsTile,
      // const SizedBox(height: 15.0),
      // legalStuff,
      const SizedBox(height: 15.0),
      Row(children: [Expanded(child: modifyProfileTile)]),
    ];

    return new Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: Padding(
          padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
          child: ListView(
              children: widgetList,
              physics: const AlwaysScrollableScrollPhysics())),
    );
  }
}
