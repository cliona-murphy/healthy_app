import 'package:flutter/cupertino.dart';
import 'package:direct_select/direct_select.dart';
import 'package:flutter/material.dart';
import 'package:healthy_app/screens/activity_diary_screen/selection_item.dart';

class ActivityForm extends StatefulWidget {
  @override
  _ActivityFormState createState() => _ActivityFormState();
}

class _ActivityFormState extends State<ActivityForm> {
  final elements1 = [
    "Walking",
    "Running",
    "Cycling",
    "Swimming",
  ];
  final elements2 = [
    "Cheese Steak",
    "Chicken",
    "Salad",
  ];

  final elements3 = [
    "7am - 10am",
    "11am - 2pm",
    "3pm - 6pm",
    "7pm-10pm",
  ];

  final elements4 = [
    "Lose fat",
    "Gain muscle",
    "Keep in weight",
  ];

  int selectedIndex1 = 0,
      selectedIndex2 = 0,
      selectedIndex3 = 0,
      selectedIndex4 = 0;

  List<Widget> _buildItems1() {
    return elements1
        .map((val) => SelectionItem(
      title: val,
    ))
        .toList();
  }

  List<Widget> _buildItems2() {
    return elements2
        .map((val) => SelectionItem(
      title: val,
    ))
        .toList();
  }

  List<Widget> _buildItems3() {
    return elements3
        .map((val) => SelectionItem(
      title: val,
    ))
        .toList();
  }

  List<Widget> _buildItems4() {
    return elements4
        .map((val) => SelectionItem(
      title: val,
    ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Enter your activity"),
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
                DirectSelect(
                    itemExtent: 35.0,
                    selectedIndex: selectedIndex1,
                    child: SelectionItem(
                      isForList: false,
                      title: elements1[selectedIndex1],
                    ),
                    onSelectedItemChanged: (index) {
                      Navigator.pop(context);
                      setState(() {
                        selectedIndex1 = index;
                      });
                    },
                    items: _buildItems1()),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Text(
                    "Search our database by name",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ),
                DirectSelect(
                    itemExtent: 35.0,
                    selectedIndex: selectedIndex2,
                    child: SelectionItem(
                      isForList: false,
                      title: elements2[selectedIndex2],
                    ),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedIndex2 = index;
                      });
                    },
                    items: _buildItems2()),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Text(
                    "Select your workout schedule",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ),
                DirectSelect(
                    itemExtent: 35.0,
                    selectedIndex: selectedIndex3,
                    child: SelectionItem(
                      isForList: false,
                      title: elements3[selectedIndex3],
                    ),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedIndex3 = index;
                      });
                    },
                    items: _buildItems3()),
                Padding(
                  padding: const EdgeInsets.only(left: 10.0, top: 20.0),
                  child: Text(
                    "Select your goal",
                    style: TextStyle(
                        color: Colors.grey, fontWeight: FontWeight.w500),
                  ),
                ),
                DirectSelect(
                    itemExtent: 35.0,
                    selectedIndex: selectedIndex4,
                    child: SelectionItem(
                      isForList: false,
                      title: elements4[selectedIndex4],
                    ),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        selectedIndex4 = index;
                      });
                    },
                    items: _buildItems4()),
              ]),
        ),
      ),
    );
  }
}
