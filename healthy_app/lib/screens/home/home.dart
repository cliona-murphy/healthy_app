import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:healthy_app/models/item.dart';
import 'package:healthy_app/screens/home/settings_page.dart';
import 'package:healthy_app/services/auth.dart';
import 'package:healthy_app/shared/ConstantVars.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../main.dart';
import 'calendar.dart';
import '../food_diary_screen/foodDiary.dart';
import '../activity_diary_screen/activityDiary.dart';
import '../medication_tracker_screen/medicationTracker.dart';
import '../nutrient_screen/nutrientChecklist.dart';
import '../progress_screen/progress.dart';
import 'package:healthy_app/shared/globals.dart' as globals;
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:healthy_app/models/push_notification.dart';
import 'package:healthy_app/services/notificationmanager.dart';

// ignore: must_be_immutable
class Home extends StatefulWidget {
  String date;
  Home({ this.date});

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final AuthService _auth = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  PageController _pageController = PageController();
  FirebaseMessaging _messaging = FirebaseMessaging();
  List<Widget> _screens = [
    Progress(), FoodDiary(), ActivityDiary(), NutrientChecklist(), MedicationTracker(),
  ];
  int _selectedIndex = 0;
  String selectedDate = "";
  bool newDate = false;
  String userId = "";
  PushNotificationsManager manager;

  // void initState() {
  //   super.initState();
  //   getUid();
  //   print("initState date = " + widget.date.toString());
  //   newDate = globals.newDateSelected;
  //   manager = new PushNotificationsManager();
  //   manager.init();
  //   //registerNotification();
  // }

  Future<String> getUid() async {
    final FirebaseUser user = await auth.currentUser();
    final uid = user.uid;
    setState(() {
      userId = uid;
    });
    print(uid);
    return uid;
  }

  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  final TextEditingController _topicController =
  TextEditingController(text: 'topic');

  Widget _buildDialog(BuildContext context, Item item) {
    return AlertDialog(
      content: Text("${item.matchteam} with score: ${item.score}"),
      actions: <Widget>[
        FlatButton(
          child: const Text('CLOSE'),
          onPressed: () {
            Navigator.pop(context, false);
          },
        ),
        FlatButton(
          child: const Text('SHOW'),
          onPressed: () {
            Navigator.pop(context, true);
          },
        ),
      ],
    );
  }

  void _showItemDialog(Map<String, dynamic> message) {
    showDialog<bool>(
      context: context,
      builder: (_) => _buildDialog(context, _itemForMessage(message)),
    ).then((bool shouldNavigate) {
      if (shouldNavigate == true) {
        _navigateToItemDetail(message);
      }
    });
  }

  void _navigateToItemDetail(Map<String, dynamic> message) {
    final Item item = _itemForMessage(message);
    // Clear away dialogs
    Navigator.popUntil(context, (Route<dynamic> route) => route is PageRoute);
    if (!item.route.isCurrent) {
      Navigator.push(context, item.route);
    }
  }

  final Map<String, Item> _items = <String, Item>{};
  Item _itemForMessage(Map<String, dynamic> message) {
    final dynamic data = message['data'] ?? message;
    final String itemId = data['id'];
    final Item item = _items.putIfAbsent(itemId, () => Item(itemId: itemId))
      ..matchteam = data['matchteam']
      ..score = data['score'];
    return item;
  }

  @override
  void initState() {
    super.initState();
    getUid();
    print("initState date = " + widget.date.toString());
    newDate = globals.newDateSelected;
    manager = new PushNotificationsManager();
    manager.init();
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("onMessage: $message");
        _showItemDialog(message);
      },
      onBackgroundMessage: myBackgroundMessageHandler,
      onLaunch: (Map<String, dynamic> message) async {
        print("onLaunch: $message");
        _navigateToItemDetail(message);
      },
      onResume: (Map<String, dynamic> message) async {
        print("onResume: $message");
        _navigateToItemDetail(message);
      },
    );
    _firebaseMessaging.getToken().then((String token) {
      assert(token != null);
      print("Push Messaging token: $token");
    });
    _firebaseMessaging.subscribeToTopic("matchscore");
  }

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

  void renderCalendar() async {
    final result = await
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CalendarView(),
        ));
    if(result.isNotEmpty){
      setState(() {
        selectedDate = result;
        newDate = true;
        globals.selectedDate = selectedDate;
      });
    }
    //print(result);
  }

  renderSettingsPage() async {
    final result = await
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SettingsPage(),
        ));
    if(result.isNotEmpty){
      setState(() {
        // selectedDate = result;
        // newDate = true;
        // globals.selectedDate = selectedDate;
      });
    }
  }

  Widget build(BuildContext context){
    return StreamBuilder(
      stream: Firestore.instance.collection('settings').document(userId).snapshots(),
        builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          var country, age, weight;
          if (snapshot.hasData) {
            country = snapshot.data['country'];
            age = snapshot.data['age'].toDouble();
            weight = snapshot.data['weight'].toDouble();
          } else {
            country = "";
            age = 0.0;
            weight = 0.0;
          }
          return Scaffold(
            appBar: AppBar(
              leading: GestureDetector(
                onTap: () {
                  /* Write listener code here */
                  print("Calendar View Selected");
                  renderCalendar();
                },
                child: Icon(
                  Icons.calendar_today_outlined,
                ),
              ),
              title: newDate ? new Text(globals.selectedDate) : new Text(getCurrentDate()),
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
                    }).toList();
                  }
                  ,)],
            ),
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
          );
        });
  }
  void choiceAction(String choice){
    if(choice == ConstantVars.Settings){
      renderSettingsPage();
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