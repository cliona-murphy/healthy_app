import 'package:flutter/material.dart';
import 'package:healthy_app/services/auth.dart';
import 'package:healthy_app/services/database.dart';
import 'package:healthy_app/shared/ConstantVars.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../foodDiary.dart';
import '../activityDiary.dart';
import '../medicationTracker.dart';
import '../nutrientChecklist.dart';
import '../progress.dart';
import 'settings_list.dart';

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
    Progress(), FoodDiary(), ActivityDiary(), NutrientChecklist(), MedicationTracker(),
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
 //adding comment for commit to master backup 23/03
  void _onItemTapped(int selectedIndex){
    _pageController.jumpToPage(selectedIndex);
    setState(() {
      _selectedIndex = selectedIndex;
    });
  }

  Widget build(BuildContext context){
    return StreamProvider<QuerySnapshot>.value(
      value: DatabaseService().settings,
      child: Scaffold(
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
          ,),
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
  void choiceAction(String choice){
    if(choice == ConstantVars.Settings){
      //SettingsList();
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