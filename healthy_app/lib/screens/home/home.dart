import 'package:flutter/material.dart';
import 'package:healthy_app/services/auth.dart';
import 'package:healthy_app/services/database.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:healthy_app/screens/home/userSettings_list.dart';
import 'package:flutter_icons/flutter_icons.dart';
import '../foodDiary.dart';
import '../activityDiary.dart';
import '../medicationTracker.dart';
import '../nutrientChecklist.dart';
import '../progress.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  //this class should be updated to be named Progress and all references updated
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();

  PageController _pageController = PageController();

  List<Widget> _screens = [
    Progress(), FoodDiary(), ActivityDiary(), MedicationTracker(), NutrientChecklist(),
  ];

  int _selectedIndex = 0;

  void _onPageChanged(int index){
    setState(() {
      _selectedIndex = index;
    });
  }
  int getSelectedIndex(){
    return _selectedIndex;
  }
  void _onItemTapped(int selectedIndex){
    _pageController.jumpToPage(selectedIndex);
    setState(() {
      _selectedIndex = selectedIndex;
    });
  }

  Widget build(BuildContext context){
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().userSettings,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: PageView(
          controller: _pageController,
          children: _screens,
          physics: NeverScrollableScrollPhysics(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart,
                color: getSelectedIndex() == 0 ? Colors.blue: Colors.grey),
              label: 'Progress',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.no_food),
              label: 'Food',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.directions_run_outlined),
              label: 'Activity',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.wb_sunny),
              label: 'Nutrients',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.check),
              label: 'Meds',
            ),
          ],
          currentIndex: _selectedIndex,
    ),
    ),
    );
  }
}